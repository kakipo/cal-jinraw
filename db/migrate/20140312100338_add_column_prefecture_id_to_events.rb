class AddColumnPrefectureIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :prefecture_id, :integer
  end
end
