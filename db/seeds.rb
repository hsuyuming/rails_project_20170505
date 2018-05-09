# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

3.times do |topic|
    Topic.create!(
        title:"Topic #{topic}"
    )
end

puts "3 topic created"



10.times do |blog|
    Blog.create!(
        title:"My Blog Post #{blog}",
        body:"The app is now bootable, but you’re not quite there yet. By default, Rails expects a database to be running on localhost - so you need to point it at the db container instead. You also need to change the database and username to align with the defaults set by the postgres image.",
        topic_id: Topic.last.id
    )
end

puts "10 blog posts created"

5.times do |skill|
    Skill.create!(
        title:"Rails #{skill}",
        percent_utilized:15
    )
end

puts "5 skills created"

8.times do |portfolio_item|
    Portfolio.create!(
       title:"Portfolio title #{portfolio_item}",
       subtitle:"Ruby on Rails",
       body:"We are waiting for the outcome of the medical reports and the police investigation report to arrive at a conclusion, Singh told CNN.
       The 16-year-old girl was allegedly kidnapped Thursday night while the family was attending a wedding, then taken to a nearby forest and raped by a group of men, according to Ashok Ram, the officer in charge of the Itkhori police station, which overseas the village.
       The family said they approached the village council on Friday seeking justice, he told CNN.
       Village councils in India, called panchayats, wield significant power in rural villages throughout India and can dole out punishment. Removed from cities and the court systems, panchayats resolve local disputes simply because they're the only recourse available in remote areas. Critics denounce them as kangaroo courts and say they perpetuate patriarchy. These councils do not have any legal authority.",
       main_image:"http://via.placeholder.com/600x400",
       thumb_image:"http://via.placeholder.com/350x200"
    )
end

puts "9 portfolio created"

8.times do |portfolio_item|
    Portfolio.create!(
       title:"Portfolio title #{portfolio_item}",
       subtitle:"Angular",
       body:"We are waiting for the outcome of the medical reports and the police investigation report to arrive at a conclusion, Singh told CNN.
       The 16-year-old girl was allegedly kidnapped Thursday night while the family was attending a wedding, then taken to a nearby forest and raped by a group of men, according to Ashok Ram, the officer in charge of the Itkhori police station, which overseas the village.
       The family said they approached the village council on Friday seeking justice, he told CNN.
       Village councils in India, called panchayats, wield significant power in rural villages throughout India and can dole out punishment. Removed from cities and the court systems, panchayats resolve local disputes simply because they're the only recourse available in remote areas. Critics denounce them as kangaroo courts and say they perpetuate patriarchy. These councils do not have any legal authority.",
       main_image:"http://via.placeholder.com/600x400",
       thumb_image:"http://via.placeholder.com/350x200"
    )
end

puts "9 portfolio created"


