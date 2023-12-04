# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server


# config.ru

require 'securerandom'
File.open('.session.key', 'w') { |f| f.write(SecureRandom.hex(32)) }

use Rack::Session::Cookie, secret: File.read('.session.key'), same_site: true, max_age: 86400
