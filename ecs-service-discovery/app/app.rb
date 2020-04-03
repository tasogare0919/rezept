require "logger"
require "sinatra"

class App < Sinatra::Base
  set :server, :puma
  set :environment, ENV["APP_ENV"]&.to_sym || :development
  set :logging, Logger.new(STDOUT)

  get "/" do
    "Hello world"
  end
end
