# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
categories = Category.create([
  { name: 'Coffee - Beverage' }, 
  { name: 'Bakery - Bread' }, 
  { name: 'Pie - Pastry'},
  { name: 'Tost - Hotdog'},
  { name: 'Sandwich'},
  { name: 'Burger'},
  { name: 'Salad'},
  { name: 'Refreshment'}
])

def img(filename)
   File.open(File.join(Rails.root, 'db', 'fixtures',filename))
end

products = Product.create([
  { photo: img('espresso.jpg'), name: 'Espresso' , price: 1.00 , category_id: '1' }, 
  { name: 'Espresso double' , price: 1.30 , category_id: '1' },
  { name: 'Cappuccino' , price: 1.00 , category_id: '1' },  
  { name: 'Cappuccino double' , price: 1.30 , category_id: '1' }, 
  { name: 'Cappuccino latte' , price: 1.30 , category_id: '1' }, 
  { name: 'Greek coffee' , price: 1.00 , category_id: '1' }, 
  { name: 'Greek coffee double' , price: 1.30 , category_id: '1' }, 
  { name: 'Nescafe' , price: 1.00 , category_id: '1' }, 
  { name: 'Filter' , price: 1.00 , category_id: '1' }, 
  { name: 'Frappe' , price: 1.00 , category_id: '1' }, 
  { name: 'Freddo espresso' , price: 1.30 , category_id: '1' }, 
  { name: 'Freddo cappuccino' , price: 1.30 , category_id: '1' }, 
  { name: 'Freddoccino' , price: 2.00 , category_id: '1' }, 
  { name: 'Chocolate' , price: 1.50 , category_id: '1' }, 
  { name: 'Tea' , price: 1.00 , category_id: '1' }, 
  { name: 'Chamomile' , price: 1.00 , category_id: '1' }, 
  { name: 'Natural orange juice' , price: 1.80 , category_id: '1' },
  { name: 'French butter croissant' , price: 1.20 , category_id: '2' }, 
  { name: 'French chocolate croissant' , price: 1.40 , category_id: '2' }, 
  { name: 'French chocolate croissant maxi' , price: 1.50 , category_id: '2' }, 
  { name: 'Butter croissant mini' , price: 0.25 , category_id: '2' }, 
  { name: 'Praline croissant mini' , price: 0.35 , category_id: '2' }, 
  { name: 'Croissant with cream-raisin mini' , price: 0.30 , category_id: '2' }, 
  { name: 'Mini donut' , price: 0.40 , category_id: '2' }, 
  { name: 'Mini donut with chocolate' , price: 0.35 , category_id: '2' }, 
  { name: 'Baked donut with sugar/chocolate' , price: 1.00 , category_id: '2' }, 
  { name: 'Baked donut with chocolate coating' , price: 1.10 , category_id: '2' },
  { name: 'Wholegrain bread' , price: 0.40 , category_id: '3' }, 
  { name: 'Total multigrain bread' , price: 0.40 , category_id: '3' }, 
  { name: 'Wheat bread' , price: 0.40 , category_id: '3' }, 
  { name: 'Corn bread' , price: 0.40 , category_id: '3' }, 
  { name: 'Taste chips with paprika' , price: 0.40 , category_id: '3' }, 
  { name: 'Vanilla bread with chocolate flakes' , price: 0.45 , category_id: '3' }, 
  { name: 'Chocolate bread with chocolate flakes' , price: 0.45 , category_id: '3' }, 
  { name: 'French pastry with cream' , price: 1.70 , category_id: '3' }, 
  { name: 'French pastry with feta cheese' , price: 1.70 , category_id: '3' }, 
  { name: 'Pastries with fine cheese and feta cheese' , price: 1.60 , category_id: '3' }, 
  { name: 'Puff pastry pizza special on griddle' , price: 2.00 , category_id: '3' }, 
  { name: 'Sausage pastry' , price: 1.50 , category_id: '3' }, 
  { name: 'Potato pie with herbs' , price: 1.50 , category_id: '3' }, 
  { name: 'Covered pizza' , price: 2.00 , category_id: '3' }, 
  { name: 'Covered burger pie' , price: 2.20 , category_id: '3' }, 
  { name: 'Mini spinach cheese bites' , price: 0.40 , category_id: '3' },
  { name: 'Mini cheese cream with sesame' , price: 0.30 , category_id: '3' }, 
  { name: 'Toast only cheese on white bread' , price: 1.00 , category_id: '4' }, 
  { name: 'Toast only cheese on rye bread' , price: 1.50 , category_id: '4' },
  { name: 'Greek toast' , price: 1.80 , category_id: '4' },
  { name: 'Club sandwich' , price: 3.60 , category_id: '4' },
  { name: 'Hotdog' , price: 1.00 , category_id: '4' },
  { name: 'Baquette classic' , price: 2.30 , category_id: '5' },
  { name: 'Baquette turkey' , price: 2.50 , category_id: '5' },
  { name: 'Baquette prosciutto' , price: 2.90 , category_id: '5' },
  { name: 'Baquette spicy' , price: 2.40 , category_id: '5' },
  { name: 'Baquette sausage' , price: 2.50 , category_id: '5' },
  { name: 'Baquette chicken' , price: 2.90 , category_id: '5' },
  { name: 'Baquette beer' , price: 2.50 , category_id: '5' },
  { name: 'Baquette Italiana' , price: 2.20 , category_id: '5' },
  { name: 'Baquette halloumi' , price: 2.40 , category_id: '5' },
  { name: 'Rustic homemade' , price: 2.40 , category_id: '5' },
  { name: 'Mediterranean' , price: 2.50 , category_id: '5' },
  { name: 'English breakfast' , price: 2.60 , category_id: '5' },
  { name: 'Burger classic' , price: 1.90 , category_id: '6' },
  { name: 'Burger chicken' , price: 2.10 , category_id: '6' },
  { name: 'Cheese burger' , price: 2.10 , category_id: '6' },
  { name: 'Bacon cheese burger' , price: 2.60 , category_id: '6' },
  { name: 'Chef salad' , price: 3.60 , category_id: '7' },
  { name: 'Ceasars salad' , price: 3.60 , category_id: '7' },
  { name: 'Salad with turkey' , price: 3.60 , category_id: '7' },
  { name: 'Salad chicken parmesano' , price: 3.70 , category_id: '7' },
  { name: 'Salad Italiana' , price: 3.50 , category_id: '7' },
  { name: 'Season salad with chicken' , price: 3.50 , category_id: '7' },
  { name: 'Prosciutto/mozzarella salad' , price: 4.00 , category_id: '7' },
  { name: 'Tuna Salad' , price: 4.00 , category_id: '7' },
  { name: 'Refreshment 300ml' , price: 1.10 , category_id: '8' },
  { name: 'Refreshment 500ml' , price: 1.30 , category_id: '8' },
  { name: 'Juice 250ml' , price: 1.30 , category_id: '8' },
  { name: 'Juice 500ml' , price: 1.60 , category_id: '8' },
  { name: 'Ice tea' , price: 1.60 , category_id: '8' },
  { name: 'Ice tea - no sugar' , price: 1.70 , category_id: '8' },
  { name: 'Milko 330ml' , price: 1.70 , category_id: '8' },
  { name: 'Water 500ml' , price: 0.50 , category_id: '8' }                           
])

settings = Setting.create([
  { key: 'twitter_api_key', value: ENV['TWITTER_API_KEY'] }, 
  { key: 'twitter_api_secret', value: ENV['TWITTER_API_SECRET']  }, 
  { key: 'fb_api_key', value: ENV['FB_API_KEY']  }, 
  { key: 'fb_api_secret', value: ENV['FB_API_SECRET'] }, 
  { key: 'gateway_login', value: ENV['gateway_login'] }, 
  { key: 'gateway_password', value: ENV['gateway_password'] },
  { key: 'gateway_token', value: ENV['gateway_token'] },  
  { key: 'billing_address_city', value: ENV['billing_address_city'] }, 
  { key: 'billing_address_country', value: ENV['billing_address_country']},
  { key: 'store_title', value: 'Faee' },
  { key: 'locale', value: 'en' }
])

user = User.create( 
  :first_name => 'Xlapatsas',
  :last_name => 'Gymnosaliagkas',
  :username => 'demo',
  :email                => 'demo@demo.com', 
  :password   => 'demodemo', 
  :password_confirmation        => 'demodemo' 
)

address = Address.create(
  :label => 'oikia',
  :user_id => User.first.id,
  :street_name => 'Panepistimiou',
  :street_num => '10',
  :zipcode => '12342',
  :phone => '6969696969',
  :region => 'Athens',
  :comment => '3os orofos'
)

admin = User.create([
  :first_name => 'Admin',
  :last_name => 'Admin',
  :username => 'admin',
  :email  => 'admin@admin.com', 
  :password   => 'adminadmin', 
  :password_confirmation        => 'adminadmin',
  :admin => true
], :without_protection => true)

parent1 = Page.create(
  :name => 'Parent',
  :content => 'Parent1',
  :is_published => true,
  :in_menu => true,
  :position => 1
)
