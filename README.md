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