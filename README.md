# README

>This is a Ruby on Rails 5 application that allows users to create their own portfilois.
>image_size_web:https://placeholder.com/
### Features
-- Read time chat engine for comments
-- Blog 
-- Portfilio
-- Drag and drop interface

### Code Example

```ruby
def my_great_method
    puts "here it is"
end
```

### cmd
docker-compose run --service-ports web rails s

### cmd:create reference between table
docker-compose run web rails g migration add_topic_reference_to_blogs topic:references

### set up default value
Method1
rails g migration add_post_status_to_blogs status:integer

In migration.rb
```ruby
def change
    add_column :blogs, status, :integer , default:0
end
```
rails db:migrate


Method2 =>in the model'rb file

```ruby
after_initialize :set_defaults (method name)
def set_defaults
    self.main_image ||= "http://via.placeholder.com/600x400"
    self.thumb_image ||= "http://via.placeholder.com/350x200"
end
```

### concern
What "concern" can do?
1.essence is whenever you have some type of functionality that doesn't fully belong inside of a model file or it should be shared across a couple different models
2.Your concern should always have to deal with data there in the model directory.anything there should relate data.

``` ruby
rails g migration add_badge_to_skills badge:text

rails db:migrate

```

create a concern that can be shared accross the models

create module file in concerns folder=>placeholder.rb

```ruby
#not class is module (create help module)
module Placeholder
    extend ActiveSupport::Concern
    
    def self.image_generator(height:,width:)
        "http://via.placeholder.com/#{height}x#{width}"
    end
end
```

include the module in our model.rb file

```ruby
class Skill < ApplicationRecord
    include Placeholder
    validates_presence_of :title,:percent_utilized 

    after_initialize :set_defaults

    #setting default value regular equal=(will override the value,don't cate the value exist or not)  ||=(if self.main_image == nil self.main_image="")
    def set_defaults
        #self.badge ||= "http://via.placeholder.com/250x250"
        self.badge ||= Placeholder.image_generator(height: '250', width: '250')
    end
end

```

rails c =>Skill.create!(title:"Some skill",percent_utilize:80)


###Building an Additional Parent/Child Relationship in Rails 5
rails g model Technology name:string portfolio:references

rails db:migrate

```ruby
class Technology < ApplicationRecord
   #automatic generate
  belongs_to :portfolio
end

```

```ruby
class Portfolio < ApplicationRecord
    #need to update has_many
    has_many :technologies
    include Placeholder
    validates_presence_of :title,:body,:main_image,:thumb_image

   
    #method1
    def self.angular
        where(subtitle:"Angular")
    end
end

```

```ruby
#rails c
portfolio_id:Portfolio.last.id)
Technology.last.portfolio
Portfolio.last.technologies
p = Portfolio.last
p.technologies.create(name:"Ruby")
```

Use the different way to generate fake data.
```ruby
3.times do |technology|
    Portfolio.last.technologies.create(
        name:"Technology #{technology}"
    )
end

#rails c 
Portfolio.last.technologies.count
```

### Configuring Nested Attributes in the Model(backend)
>refactor:originally, we use "scoped action(customer query)" to filter data, now we want to use nested attribute to do that.

```ruby
class Portfolio < ApplicationRecord
    has_many :technologies
    #1 nested attributes + data validation
    accepts_nested_attributes_for :technologies,
                                  reject_if: lambda{ |attrs| attrs['name'].blank?}

    include Placeholder
    validates_presence_of :title,:body,:main_image,:thumb_image
end

#rails c => test the samll functionality change work well or not.
#accepts_nested_attributes_for->technologies_attributes , be carefule need pass array(collect).
Portfolio.create!(title:"Web app",subtitle:"sdasda",body:"sdgsdgsdg",technologies_attributes:[{name:"Ruby on Rails"},{name:"Angular"},{name:"Inoic"}])

Portfolio.last.technologies.count
``` 

```sql
 (0.3ms)  BEGIN
  SQL (0.5ms)  INSERT INTO "portfolios" ("title", "subtitle", "body", "main_image", "thumb_image", "created_at", "updated_at") VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING "id"  [["title", "Web app"], ["subtitle", "sdasda"], ["body", "sdgsdgsdg"], ["main_image", "http://via.placeholder.com/600x400"], ["thumb_image", "http://via.placeholder.com/350x200"], ["created_at", "2018-05-10 13:33:58.484550"], ["updated_at", "2018-05-10 13:33:58.484550"]]
  SQL (4.1ms)  INSERT INTO "technologies" ("name", "portfolio_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["name", "Ruby on Rails"], ["portfolio_id", 18], ["created_at", "2018-05-10 13:33:58.486683"], ["updated_at", "2018-05-10 13:33:58.486683"]]
  SQL (1.2ms)  INSERT INTO "technologies" ("name", "portfolio_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["name", "Angular"], ["portfolio_id", 18], ["created_at", "2018-05-10 13:33:58.492395"], ["updated_at", "2018-05-10 13:33:58.492395"]]
  SQL (1.5ms)  INSERT INTO "technologies" ("name", "portfolio_id", "created_at", "updated_at") VALUES ($1, $2, $3, $4) RETURNING "id"  [["name", "Inoic"], ["portfolio_id", 18], ["created_at", "2018-05-10 13:33:58.497756"], ["updated_at", "2018-05-10 13:33:58.497756"]]
   (0.9ms)  COMMIT
```
### Configuring Nested Attributes in the Model(FrontEnd)
>Part1. portfolios_controller.rb 
```ruby
class PortfoliosController < ApplicationController
    def new
        @portfolio_item=Portfolio.new
        #instantiate three version s of this portfolio item of technologies
        3.times {@portfolio_item.technologies.build}
    end
end

def create
        @portfolio_item=Portfolio.new(params.require(:portfolio).permit(:title, :subtitle, :body, 
            technologies_attributes: [:name]))
```

>Part2. new.html.erb Implement the other form
```erb
<ul>
    <%= form.fields_for :technologies do |technology_form| %>
    <li>
        <%= technology_form.label :name %>
        <%= technology_form.text_field :name %>
    </li>
    <% end %>
</ul>
```

>Part3. modify show.html.erb
```erb
<% @portfolio_item.technologies.each do |t| %>
    <p><%= t.name %></p>
<%end%>
```


### Virtual attribute
> an attribute that we call on some model that isn't actually a column name. create something without having to do a migration.

in the user.rb add virtual attribute.
```ruby
#virtual attribute
def first_name
    #self.name is saying sepecific name for the user that we're talking about.
    # "John$Smith".split("$").first
    # self.name.split[0]
    self.name.split.first
end

def last_name
    self.name.split.last
end
```


> OpenStruct can use us to create mimitracking data(e.p. mock data)

```ruby
def current_user #user class or OpenStruct class
    #super || guest_user(actually mimicking a guest user.)
    super || OpenStruct.new(name:"Guest User",first_name:"Guest",last_name:"User",email:"guest@example.com")
  end
```

> type check 

```ruby 
name = OpenStruct.new(name:"Guest User",first_name:"Guest",last_name:"User",email:"guest@example.com")
name.is_a?(parentType)
```