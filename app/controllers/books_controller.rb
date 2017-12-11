class BooksController < ApplicationController

  get '/books' do
    if signed_in?
      @books = Book.all
      @authors = Author.all
      erb :'/books/index'
    else
      redirect to '/signin'
    end
  end

  get '/books/menu' do
    if signed_in?
      @books = Book.all
      @authors = Author.all
      erb :'/menu'
    else
      redirect to '/signin'
    end
  end

  get '/books/new' do
    if signed_in?
      erb :'/books/new'
    else
      redirect to '/signin'
    end
  end

  post '/books' do
    @book = Book.create(:title => params[:title], :user_id => current_user.id)
    @book.author = Author.find_or_create_by(:name => params[:name])
    @book.author.id = @book.author_id
    @book.save
    redirect to "/books/#{@book.id}"
  end

  get '/books/:id' do
    if signed_in?
      @book = Book.find_by_id(params[:id])
      erb :'books/show'
    else
      redirect to '/signin'
    end
  end

  get '/books/:id/edit' do
    if signed_in?
        @book = Book.find_by_id(params[:id])
        @authors = Author.all
        if @book.user_id == current_user.id
          erb :'books/edit'
        end
    else
      redirect to '/signin'
    end
  end

   post '/books/:id' do
     if params[:title] == "" || params[:name] == ""
       redirect to "/books/#{params[:id]}/edit"
     else
       @book = Book.find_by_id(params[:id])
       #binding.pry
       @book.update(:title => params[:title])
       @book.author.update(:name => params[:name])
       @book.author = Author.find_or_create_by(name: params[:name])

       @book.save
       redirect to "/books/#{@book.id}"
     end
   end

   delete '/books/:id/delete' do
       if signed_in?
         @book = Book.find_by_id(params[:id])
         if @book.user_id == current_user.id
           @book.delete
           redirect to '/books'
         else
           redirect to '/books/menu'
         end
      else
        redirect to '/signin'
      end
    end
end
