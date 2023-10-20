# Create gem spec file
Gem::Specification.new do |s|
  s.name       = 'parroquia'
  s.version    = '0.0.1'
  s.date       = '2023-10-20'
  s.summary    = "Parroquia San Judas Tadeo"
  s.description = "Servicio Parroquial San Judas Tadeo"
  s.authors    = ["Francisco Javier Borja Lobato"]
  s.email      = 'fjbl2788@gmail.com'
  s.homeoage   = 'https://github.com/franclobo/Parroquia-San-Judas-Tadeo'
  s.license    = 'MIT'
  s.required_ruby_version = '>= 3.2.2'
  s.files      = Dir["lib/**/*.rb"]
  s.executables << 'parroquia'
  s.require_paths << 'lib'

  s.add_dependency 'fxruby', '~> 1.6', '>= 1.6.33'
  s.add_dependency 'pg'
  s.add_dependency 'prawn'
end

