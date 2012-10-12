# X-Revision

  Rack middleware, that adds X-Rev header with revision id (git commit id)

  By default it looks for REVISON file that capistrano adds during deploy,
  if it doesn't find it, then it tries to run git, and get the latest commit

  STILL IN PROGRESS

## Installation

Add this line to your application's Gemfile:

    gem 'xrevision'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xrevision

## Usage

### Rails

   TODOS / IDEAS:

     1. Use railtie to load it automatically
     2. Prepare specific rails class, that use Rails.root

    use Rack::XRev, app, :app_path => Rails.root

### Options:

  :app_path - Specify app directory, by default it's Dir.pwd 

  :file_name - File with revision number, default: 'REVISION'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
