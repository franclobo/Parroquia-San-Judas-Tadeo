# Create gem spec file
Gem::Specification.new do |s|
  s.name = 'parroquia'
  s.version = '1.1.14'
  s.summary = 'Parroquia San Judas Tadeo'
  s.description = 'Servicio Parroquial San Judas Tadeo'
  s.authors = ['Francisco Javier Borja Lobato']
  s.email = 'fjbl2788@gmail.com'
  s.homepage = 'https://github.com/franclobo/Parroquia-San-Judas-Tadeo'
  s.license = 'MIT'
  s.required_ruby_version = '>= 3.2.2'
  s.files = Dir['lib/**/*']
  s.executables << 'parroquia'
  s.require_paths << 'lib'

  s.add_dependency 'fxruby', '~> 1.6', '>= 1.6.46'
  s.add_dependency 'pg', '~> 1.5', '>= 1.5.4'
  s.add_dependency 'prawn', '~> 2.4', '>= 2.4.0'
  s.metadata['rubygems_mfa_required'] = 'true'
end
