class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
   :rememberable, :trackable, :validatable #, :recoverable

end