# rack-xrevision

  Rack middleware, that adds X-Rev header with revision id (git commit id)

  By default it looks for REVISON file that capistrano adds during deploy,
  if it doesn't find it, then it tries to run git, and get the latest commit

## Installation

Add this line to your application's Gemfile:

    gem 'rack-xrevision'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-xrevision

## Usage

in config/application.rb

    config.middleware.use Rack::Xrevision, :app_path => Rails.root


in config.ru

    use Rack::Xrevision, :app_path => Dir.pwd


### Options:

  :app_path - Specify app directory, by default it's Dir.pwd 

  :file_name - File with revision number, default is 'REVISION'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
