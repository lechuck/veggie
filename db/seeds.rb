# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

user1 = User.new(:username => 'tony', :password => 'tony', :password_confirmation => 'tony',
            :email => 'tony@colorshki.com')
user1.save
            
bamboo = Restaurant.new(:name => 'New Bamboo Center', 
                  :website => 'http://newbamboocenter.com/', :info => '
                  New Bamboo Center on vuonna 1997 perustettu kiinalainen ravintola. Kiinalaisten ruokien lisäksi ravintolassamme tarjoillaan malesialaisia curryruokia. Pyrimme käyttämään tuoreita raaka-aineita, muutamaa Suomesta vaikeasti saatavissa olevaa erikoisuutta lukuunottamatta.
                  Alkoholia emme saa myydä, koska kiinteistö jossa ravintolamme sijaitsee, on raittiusseuran omaisuutta.', :user => user1)

bamboobranch = Branch.create(:street => 'Annankatu 29', :city => 'Helsinki', :hours => '11-17', :phone => '(09) 694 3117', :email => 'bambo@newbamboocenter.fi')
bamboo.branches << bamboobranch
bamboo.save

pikkunepal = Restaurant.new(:name => 'Pikku Nepal', 
                  :website => 'http://pikkunepal.fi/', :info => '
                  PIKKU NEPAL PIKKU NEPAL muutamaa Suomesta vaikeasti saatavissa olevaa erikoisuutta lukuunottamatta.
                  Alkoholia emme saa myydä, koska kiinteistö jossa ravintolamme sijaitsee, on raittiusseuran omaisuutta.', :user => user1)

pikkubranch = Branch.create(:street => 'Annankatu 27', :city => 'Helsinki', :hours => '11-17', :phone => '(09) 694 31137', :email => 'gkie@newbamboocenter.fi')
pikkunepal.branches << pikkubranch
pikkunepal.save

Restaurant.all.each do |restaurant|
  10.times do
    review = Review.new(:food => rand(5) , :service=> rand(5), :environment => rand(5), :user => user1)
    restaurant.reviews << review
  end
end

res1 = Restaurant.find(:first)
res1.tag_list = 'malesialainen, kiinalainen, nouto'
res1.save

Portion.create(:name => 'Kung-Po tofu', :restaurant => Restaurant.find_by_name('New Bamboo Center'), :user => 
              user1, :veganmod => 'Ei muutoksia.', :price => 8.90, :description => 'Uppopaistettua tofua soijakastikepohjaisella kastikkeella.')