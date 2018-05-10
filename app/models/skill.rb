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
