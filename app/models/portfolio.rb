class Portfolio < ApplicationRecord
    include Placeholder
    validates_presence_of :title,:body,:main_image,:thumb_image

   
    #method1
    def self.angular
        where(subtitle:"Angular")
    end

    #method2
    scope :ruby_on_rails_portfolio_items, -> {where(subtitle:"Ruby on Rails")}

    after_initialize :set_defaults

    #setting default value regular equal=(will override the value,don't cate the value exist or not)  ||=(if self.main_image == nil self.main_image="")
    def set_defaults
        self.main_image ||= Placeholder.image_generator(height: '600', width: '400')
        self.thumb_image ||= Placeholder.image_generator(height: '350', width: '200')
    end
end

#if self.main_image==nil
#    self.main_image=http://via.placeholder.com/350x200
#end
