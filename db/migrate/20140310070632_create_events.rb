class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :url
      t.date :event_date
      t.string :title
      t.string :place
      t.string :address
      t.integer :price
      t.integer :capacity
      t.text :description

      t.timestamps
    end
  end
end
