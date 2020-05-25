require "dsp/server"

module DSP
  module Producer
    def broadcast(channel, message)
      pub_sub_server = DSP::Server.connect!
      pub_sub_server.broadcast(channel, message)
    end
  end
end