require "set"
require "drb/drb"

module DSP
  class Server
    URI = "druby://localhost:9000"

    def self.start!(daemon: false)
      DRb.start_service(URI, DSP::Server.new)
      DRb.thread.join if daemon
    end

    def self.connect!
      DRbObject.new_with_uri(URI)
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

      @channels[channel][:subscriptions].each do |s|
        DRbObject.new_with_uri(s).handle(message)
      end
    end
  end
end