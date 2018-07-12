# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Asset.create([{symbol: 'FB'}, {symbol: 'TWTR'}, {symbol: 'AAPL'}, {symbol: 'GOOG'}])
user1 = User.create(username: 'shun', name: 'Shun Yao')
user1.search_histories.create([{asset_id: 2}, {asset_id: 3}])
user1.watchlists.create([{asset_id: 1}, {asset_id: 4}])
user1.portfolio_assets.create([{asset_id: 2, position_type: 'Short'}, {asset_id: 1, position_type: 'Long'}])
