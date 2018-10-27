class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :name, null: false
      t.integer :price_cents, null: false
      t.date :date_published, null: false

      t.timestamps
    end
    add_index :books, :name, unique: true
  end
end
