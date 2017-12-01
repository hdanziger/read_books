class UsersController < ApplicationController

  get '/signup' do #loads form to sign up
    if !signed_in?
      erb :'users/signup'
    else
      redirect to "/tweets"
    end
  end

  post '/signup' do
    if params[:username]== "" || params[:password]== ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/books"
    end
    #submits a post request to sign up
    #logs the user in and adds user_id to sessions hash
    #redirect to home page
  end

  get '/signin' do #loads form to log in
    if !signed_in?
      erb :'users/signin'
    else
      redirect '/books'
    end
  end

  post '/signin' do #posts request to log in
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/books"
    else
      redirect to '/signup'
    end
  end
end
