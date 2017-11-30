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
end
