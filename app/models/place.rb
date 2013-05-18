class Place < ActiveRecord::Base
  attr_accessible :address, :description, :email, :name, :phone,
    :seat_amount, :socket, :wifi, :projector

  belongs_to :user
  
  validates :user,
    :presence => true
  validates :address, :description, :email, :name, :phone, :seat_amount,
    :presence => true
  validates :socket, :wifi, :projector,
    :inclusion => {:in => [true, false]}
  validates :email,
    :uniqueness => { :case_sensitive => false }
  validates :seat_amount,
    :numericality => true
  validates :projector, :socket, :wifi,
    :inclusion => {:in => [true, false]}

end
