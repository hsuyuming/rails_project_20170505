class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates_presence_of :name

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

end
