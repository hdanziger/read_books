class UsersController < ApplicationController

  get '/signup' do
    if !signed_in?
      erb :'users/signup'
    else
      redirect to "/books/menu"
    end
  end

  post '/signup' do
    if params[:username]== "" || params[:password]== ""
      redirect to '/signup'
    else
      @user = User.new(:username => params[:username], :password => params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to "/books/menu"
    end
  end

  get '/signin' do
    if !signed_in?
      erb :'users/signin'
    else
      redirect to "/books/menu"
    end
  end

  post '/signin' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/books/menu"
    else
      redirect to '/signup'
    end
  end

end
