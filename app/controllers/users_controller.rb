class UsersController < ApplicationController

  get '/signup' do
    if !signed_in?
      erb :'users/signup'
    else
      redirect to "/books"
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

  end

  get '/signin' do
    if !signed_in?
      erb :'users/signin'
    else
      redirect '/books'
    end
  end

  post '/signin' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/books"
    else
      redirect to '/signup'
    end
  end
end
