# README

>This is a Ruby on Rails 5 application that allows users to create their own portfilois.

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
