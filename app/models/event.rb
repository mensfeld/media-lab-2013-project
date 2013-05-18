class Event < ActiveRecord::Base
  attr_accessible :name, :description, :email, :phone, :website

  belongs_to :user
  
  validates :user,
    :presence => true
  validates :name, :description, :email, :phone,
    :presence => true

end
