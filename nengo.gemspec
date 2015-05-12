Gem::Specification.new do |s|
  s.name        = "nengo"
  s.version     = "0.0.1"
  s.date        = "2015-05-12"
  s.summary     = "Simply convert among Japanese year systems"
  s.description = "A simple ruby gem to convert years to various Japanese date systems"
  s.authors     = ["Eric Turner"]
  s.email       = "ericturnerdev@gmail.com"
  s.files       = %w(lib/nengo.rb lib/data/animal_list_eto.json lib/data/element_list_eto.json lib/data/jidai_data.json lib/nengo.rb)
  s.homepage    =
    "http://github.com/etdev/nengo"

  s.add_dependency 'json'
  s.license       = "MIT"
end
