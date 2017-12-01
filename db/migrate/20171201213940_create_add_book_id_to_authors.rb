class CreateAddBookIdToAuthors < ActiveRecord::Migration[5.1]
  def change
    add_column :authors, :book_id, :integer
  end
end
