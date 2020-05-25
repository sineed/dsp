require "set"
require "drb/drb"

module DSP
  class Server
    URI = "druby://localhost:9000"

    class << self
      def start!(daemon: false, uri: URI)
        DRb.start_service(uri, DSP::Server.new)

        if daemon
          puts "DSP started: #{DRb.uri}"
          puts "Waiting for messages..."
          DRb.thread.join
        end
      end

      def connect!
        config = DSP::Config
        DRbObject.new_with_uri(config.uri)
      end
    end


    def initialize
      @channels = {}
    end

    def add_subscription(channel, server_uri)
      @channels[channel] ||= {
        name: channel,
        subscriptions: Set.new
      }

      @channels[channel][:subscriptions].add(server_uri)
    end

    def broadcast(channel, message)
      return unless @channels[channel]
      puts "[#{channel}] Handling message #{message}"

      @channels[channel][:subscriptions].each do |s|
        DRbObject.new_with_uri(s).handle(message)
      end
    end
  end
end