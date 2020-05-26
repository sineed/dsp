require "drb/drb"
require "dsp/server"

module DSP
  module Consumer
    attr_reader :subscription_server

    def subscribe(channel)
      @subscription_server ||= DRb.start_service(nil, self)

      pub_sub_server = DSP::Server.connect!
      pub_sub_server.add_subscription(channel, @subscription_server.uri)
    end
  end
end