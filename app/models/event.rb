class Event < ActiveRecord::Base
  attr_accessible :name, :description, :email, :phone, :website

  belongs_to :user
  
  validates :user,
    :presence => true
  validates :name, :description, :email, :phone,
    :presence => true

  has_attached_file :avatar,
    :styles => { :medium => "300x300>", :thumb => "90x60#", :big => '620x315#' },
    :default_url => "/images/:style/missing.png"

end
