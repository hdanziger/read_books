class ApplicationController < Sinatra::Base

  configure do
  enable :sessions
  set :sessions_secret, "readingbooks"
  set :views, "app/views/"
end

  get '/' do
    erb :index
  end

  helpers do
   def current_user
     @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
   end

   def signed_in?
     !!session[:user_id]
   end
  end


end
