class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.references :order, foreign_key: true, null: false
      t.references :book, foreign_key: true, null: false
      t.integer :quantity, null: false, default: 1
      t.integer :total_amount_cents, null: false

      t.timestamps
    end

    add_index :line_items, [:order_id, :book_id], unique: true
  end
end
