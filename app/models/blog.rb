class Blog < ApplicationRecord
    enum status: {draft:0,published:1}
    
    #add validation part
    validates_presence_of :title,:body

    belongs_to :topic
end
