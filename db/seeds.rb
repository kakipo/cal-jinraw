# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require "csv"

CSV.foreach('db/seeds.csv') do |row|
  # url: string
  # title: string
  # place: string
  # address: string
  # price: integer
  # capacity: integer
  # session_id: string
  # start_at: datetime
  # end_at: datetime
  # cat_beginner_flg: boolean
  # cat_pro_flg: boolean
  # prefecture_id: integer
  Event.create!(
    url: row[0],
    title: row[1],
    place: row[2],
    address: row[3],
    price: row[4].to_i,
    capacity: row[5].to_i,
    session_id: row[6],
    start_at: row[7],
    end_at: row[8],
    cat_beginner_flg: row[9],
    cat_pro_flg: row[10],
    prefecture_id: row[11].to_i
  )
end