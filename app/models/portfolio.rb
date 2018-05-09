class Portfolio < ApplicationRecord
    validates_presence_of :title,:body,:main_image,:thumb_image

   
    #method1
    def self.angular
        where(subtitle:"Angular")
    end

    #method2
    scope :ruby_on_rails_portfolio_items, -> {where(subtitle:"Ruby on Rails")}
end
