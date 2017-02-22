class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :role
  has_many :events, :dependent => :destroy
  has_many :animals, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :informations, :dependent => :destroy
  has_many :pets, :dependent => :destroy
  has_many :images, :dependent => :destroy

  def admin?
  self.role.name == "Admin"
  end

  def member?
  self.role.name == "Member"
  end

  def guest?
    self.role.name =="Guest"
  end  
end