class Place < ActiveRecord::Base
  attr_accessible :address, :description, :email, :name, :phone, :projector, :seat_amount, :socket, :wifi

  belongs_to :user
  
  validates :user,
    :presence => true
  validates :address, :description, :email, :name, :phone, :projector,
    :seat_amount, :socket, :wifi,
    :presence => true
  validates :email,
    :uniqueness => { :case_sensitive => false }
  validates :seat_amount,
    :numericality => true
  validates :projector, :socket, :wifi,
    :inclusion => {:in => [true, false]}

end
