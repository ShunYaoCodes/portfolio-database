# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Asset.destroy_all
User.destroy_all
SearchHistory.destroy_all
Watchlist.destroy_all
PortfolioAsset.destroy_all

for i in 0..4 do 
    name = Faker::Name.unique.name
    Asset.create!([{symbol: 'FB'}, {symbol: 'TWTR'}, {symbol: 'AAPL'}, {symbol: 'GOOG'}])
    user = User.create!(username: 'shun', name: name, password: 'helloworld', password_confirmation: 'helloworld')
    user.search_histories.create!([{asset_id: 2}, {asset_id: 3}])
    user.watchlists.create!([{asset_id: 1}, {asset_id: 4}])
    user.portfolio_assets.create!([{asset_id: 2, position_type: 'Short'}, {asset_id: 1, position_type: 'Long'}, {asset_id: 3, position_type: 'Short'}, {asset_id: 4, position_type: 'Long'}])
end

