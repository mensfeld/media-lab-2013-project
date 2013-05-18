class Place < ActiveRecord::Base
  attr_accessible :address, :description, :email, :name, :phone,
    :seat_amount, :socket, :wifi, :projector, :avatar

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


  has_attached_file :avatar, 
    :styles => { :medium => "300x300>", :thumb => "100x100#" },
    :default_url => "/images/:style/missing.png"

end
