# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create(category:1,name:'Gamla filmer',default_price:50,points:5)
Category.create(category:2,name:'Vanliga filmer',default_price:100,points:10)
Category.create(category:3,name:'Nya utgåvor',default_price:200,points:20)

Customer.create(name:'Fredrik Fredriksson',address:'Storgata 3 Fredrika',points:0)

Article.create(article_number: 1, name: 'Kasta loss! Sommaren är här', category: 3, price: 200, points:20)