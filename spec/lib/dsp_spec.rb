require "dsp"

RSpec.describe DSP do
  class Bar
    include DSP::Consumer
    attr_reader :bared

    def initialize
      @bared = false
    end

    def handle(message)
      @bared = true
    end
  end

  class Baz
    include DSP::Consumer
    attr_reader :bazed

    def initialize
      @bazed = false
    end

    def handle(message)
      @bazed = message
    end
  end

  around(:each) do |example|
    pub_sub_process = fork do
      DSP.start_server(daemon: true)
    end

    example.run

    Process.kill("KILL", pub_sub_process)
  end

  it "works" do
    bar = Bar.new
    baz = Baz.new
    bar.subscribe(:my_channel)
    baz.subscribe(:my_channel)

    producer_process = fork do
      class Foo
        include DSP::Producer

        def call
          broadcast(:my_channel, a: 1)
        end
      end

      Foo.new.call
    end

    Process.wait(producer_process)

    expect(bar.bared).to be_truthy
    expect(baz.bazed).to eq({a: 1})
  end
end