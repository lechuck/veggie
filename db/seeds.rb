# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

admin = User.new(:username => 'admin', :password => 'admin', :password_confirmation => 'admin',
  :email => 'admin@trolololo.fi', :admin => true)
admin.save

users = %w(mikko tony simo anna juhani elias pentti maria kristiina daniela juho simeon)

users.each do |name|
  User.create(:username => name, :password => name, :password_confirmation => name, :email => "#{name}@blaa.fi")
end

restaurants = ['Maoz', 'Lemon Grass', 'Chilli', 'Stadin kebab', 'Kasvisbaari', 'Kipsari', 'Marjon grilli', 'Tuktuk', 'Al Zobaidi']

tags = %w(kiinalainen, pizza, take-away, thaimaalainen, tofu, malesialainen, intialainen, nepalilainen, falafel, hampurilainen,
raw, lounas, kallis, halpa, kreikkalainen, etiopialainen, dal, currytofu, tyylikäs, edullinen)

portions = ['Kung-po tofu', 'Pita falafel', 'Rulla falafel', 'Falafel burger', 'Currytofu', 'Marinoidut herkkusienet',
  'Uppopaistetus rasvasuolasokeripallot', 'Hernefalafel', 'Seitanpihvi konjakkikastikkeella', 'Vartaassa grillattu kokonainen soijasika']

comments = ["Tosi jees.", "Kävin tänään ja oli uskomatonta.", "Samaa mieltä kuin ylläoleva.", "Ystävällinen palvelu, hyvä ruoka."]

restaurants.each do |name|
  user = User.find_by_username(users[rand(users.size)])
  restaurant = Restaurant.new(:name => name, :website => 'http://ravinto.la', :info => "Hyvä ruokapaikka", :user => user)
  branch = Branch.create(:street => 'Kaikukatu 1', :city => 'Helsinki', :hours => '11-17', :phone => '(09) 694 31137', :email => 'gkie@newbamboocenter.fi')
  restaurant.branches << branch

  rand(50).times do
    user = User.find_by_username(users[rand(users.size)])
    review = Rating.new(:food => rand(5) , :service=> rand(5), :environment => rand(5), :user => user)
    restaurant.reviews << review
  end

  rand(5).times do
    restaurant.tag_list << tags[rand(tags.size)]
  end

  rand(10).times do
    user = User.find_by_username(users[rand(users.size)])
    Portion.create(:name => portions[rand(portions.size)], :restaurant => restaurant,
      :user => user, :veganmod => 'Ei muutoksia.', :price => 8.90, :description => 'Lorem ipsum')
  end

  rand(5).times do
    user = User.find_by_username(users[rand(users.size)])
    comment = Comment.new(:comment => comments[rand(comments.size)], :user => user, :restaurant => restaurant)
    restaurant.comments << comment
  end

  restaurant.save
end

Restaurant.all.each do |restaurant|
  rand(15).times do
    user = User.find_by_username(users[rand(users.size)])
    restaurant.like(user)
  end
end
  