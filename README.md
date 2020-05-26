# DSP

*D*istributed *S*ubscribe and *P*ublish. This is an implementation of publish/subscribe mechanism using dRuby.


## Usage

```ruby

# Starts pub/sub server in another Ruby process
pub_sub_service = fork do
  DSP.start_server(daemon: true)
end


class Bar
  include DSP::Consumer
  attr_reader :performed

  def handle(channel, event)
    @performed = true
  end
end

bar = Bar.new
# Subscribes to the messages from the channel
bar.subscribe(:my_channel)


# Publishes message from another Ruby process
publish_service = fork do
  class Foo
    include DSP::Producer

    def call
      broadcast(:my_channel, a: 1)
    end
  end

  Foo.new.call
end

puts bar.performed # true


Process.kill("KILL", pub_sub_service)
Process.kill("KILL", publish_service)
```