class AddCategoryColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :cat_beginner_flg, :boolean
    add_column :events, :cat_pro_flg, :boolean
    add_column :events, :cat_weekday_flg, :boolean
    add_column :events, :cat_holiday_flg, :boolean
    add_column :events, :cat_allnight_flg, :boolean
  end
end
