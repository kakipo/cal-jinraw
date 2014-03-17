class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :url
      t.string :title
      t.string :place
      t.string :address
      t.integer :price
      t.integer :capacity
      t.timestamps
    end
  end
end
