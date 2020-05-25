# DSP

*D*istributed *S*ubscribe and *P*ublish.


```ruby
# in instance A
class Foo
  include DSP::Producer

  def call
    broadcast(:my_channel, a: 1)
  end
end

# in instance B
class Bar
  extend DSP::Consumer
  subscribe :my_channel

  def handle(event)
    puts event
  end
end

#in instance C
DSP.run_server

#then in instance A
Foo.new.call

#then in instance B stdout
# {a: 1}
```