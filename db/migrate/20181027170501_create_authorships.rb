class CreateAuthorships < ActiveRecord::Migration[5.2]
  def change
    create_table :authorships do |t|
      t.references :author, foreign_key: true, null: false
      t.references :book, foreign_key: true, null: false

      t.timestamps
    end

    add_index :authorships, [:author_id, :book_id], unique: true
  end
end
