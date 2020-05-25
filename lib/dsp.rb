require "dsp/server"
require "dsp/consumer"
require "dsp/producer"
require "dsp/config"

module DSP
  class << self
    def start_server(options = {})
      DSP::Server.start!(options)
    end

    def config
      DSP::Config.instance
    end

    def configure
      yield DSP::Config
    end
  end
end