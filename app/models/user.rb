class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
   :rememberable, :trackable, :validatable #, :recoverable

  ROLES = %w{ organizer owner }

  has_many :places

  validates :role,
    :inclusion => { :in => ROLES, :allow_nil => false }

  ROLES.each do |role|
    define_method "#{role}?" do
      self.role == role
    end
  end

end
