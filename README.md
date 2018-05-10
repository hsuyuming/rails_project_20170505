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