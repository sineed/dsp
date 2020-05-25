require "dsp/server"
require "dsp/consumer"
require "dsp/producer"

module DSP
  class << self
    def start_server(options = {})
      DSP::Server.start!(options)
    end
  end
end