Gem::Specification.new do |gem|
  gem.authors = ['Jake M']
  gem.email = ['jakemaskiewicz@gmail.com']
  gem.description = 'Sock is a socket utility library.'
  gem.summary = 'a socket utility library'
  gem.homepage = 'https://github.com/jakemask/sock'

  gem.files = `git ls-files`.lines.map(&:strip)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})

  gem.name = 'sock'
  gem.require_paths = ['lib']

  gem.version = '0.0.1'
  gem.license = 'MIT'

  gem.add_dependency('colorize', '~> 0.7', '>= 0.7.7')
end
