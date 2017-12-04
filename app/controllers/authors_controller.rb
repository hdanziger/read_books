class AuthorsController < ApplicationController

  get '/authors' do
    @books = Book.all
   @authors = Author.all
   erb :'authors/index'
 end

 get '/authors/:id' do
  @author = Author.find_by_id(params[:id])
  erb :'authors/show'
end


end
