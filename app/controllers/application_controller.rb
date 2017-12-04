class ApplicationController < Sinatra::Base

  configure do
  enable :sessions
  set :session_secret, "readingbooks"
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

 get '/logout' do
    if signed_in?
      session.destroy
      redirect to '/signin'
    else
      redirect to '/'
    end
  end

end
