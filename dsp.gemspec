Gem::Specification.new do |s|
  s.name        = 'dsp'
  s.version     = '0.0.1'
  s.date        = '2020-05-25'
  s.summary     = "Distributed Subscribe and Publish"
  s.description = "Implementation of publish/subscribe mechanism using dRuby."
  s.authors     = ["Denis Tataurov"]
  s.email       = "sineedus8@gmail.com"
  s.license     = 'MIT'

  s.executables = ["dsp"]
  s.files       = ["bin", "lib"]

  s.add_development_dependency "rspec", ">= 3.0.0"
end