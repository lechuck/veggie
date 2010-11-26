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
            
Restaurant.create(:name => 'New Bamboo Center', :address => 'Annankatu 29, Helsinki',  
                  :website => 'http://newbamboocenter.com/', :info => '
                  New Bamboo Center on vuonna 1997 perustettu kiinalainen ravintola. Kiinalaisten ruokien lisäksi ravintolassamme tarjoillaan malesialaisia curryruokia. Pyrimme käyttämään tuoreita raaka-aineita, muutamaa Suomesta vaikeasti saatavissa olevaa erikoisuutta lukuunottamatta.
                  Alkoholia emme saa myydä, koska kiinteistö jossa ravintolamme sijaitsee, on raittiusseuran omaisuutta.',              
                  :hours => '11-17')

Portion.create(:name => 'Kung-Po tofu', :restaurant => Restaurant.find_by_name('New Bamboo Center'), :user => 
              user1, :veganmod => 'Ei muutoksia.')