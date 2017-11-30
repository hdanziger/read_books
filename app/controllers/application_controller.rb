class ApplicationController < Sinatra::Base

  configure do
  enable :sessions
  set :sessions_secret, "readingbooks"
  set :views, "app/views/"
end

  get '/' do
    erb :index
  end

end
