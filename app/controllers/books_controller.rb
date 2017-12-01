class BooksController < ApplicationController

  get '/books' do
    @books = Book.all
    erb :'/books/index'
  end

  get '/books/new' do
    erb :'/books/new'
  end

  post '/books' do
    @book = Book.create(:title => params[:title])
    @book.author = Author.find_or_create_by(:name => params[:name])
    @book.save
    redirect '/books'
  end

  get '/books/:id' do
    @book = Book.find_by_id(params[:id])
    erb :'books/show'
  end

  get '/books/:id/edit' do
   @book = Book.find_by_id(params[:id])
    #if @book.user_id == current_user.id
       erb :'books/edit'
   end

   post '/books/:id/edit' do
     @book = Book.find_by_id(params[:id])
     @book.title = params[:title]
     @book.save
     redirect to "/books/#{@book.id}"
   end

end
