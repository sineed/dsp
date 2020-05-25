require "drb/drb"
require "dsp/server"

module DSP
  module Consumer
    def subscribe(channel)
      @server ||= DRb.start_service(nil, self)

      pub_sub_server = DSP::Server.connect!
      pub_sub_server.add_subscription(channel, @server.uri)
    end
  end
end