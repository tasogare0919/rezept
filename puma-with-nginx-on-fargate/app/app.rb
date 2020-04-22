require "logger"
require "sinatra"

class App < Sinatra::Base
  set :server, :puma
  set :logging, Logger.new(STDOUT)

  get "/" do
    "Hello world"
  end
end
