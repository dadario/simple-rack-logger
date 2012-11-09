# SimpleRackLogger

A simple rack for log information from environment.

For use in Rack application to log information from environment. Special from request data.

## Installation

Add this line to your application's Gemfile:

    gem 'simple_rack_logger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_rack_logger

## Usage

use Rack::RequestLogger, Logger.new(File.open("log/development.log", File::WRONLY | File::APPEND))

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
