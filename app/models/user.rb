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
  has_many :devices, :dependent => :destroy
  has_many :notifications, :dependent => :destroy
  has_many :risks, :dependent => :destroy
  has_many :adoptions, :dependent => :destroy
  before_create :set_default_role
  scope :email, -> (email) { where email: email }
  phony_normalize :phone, default_country_code: 'CL'
  validates :name, presence: true
  has_attached_file :avatar,
:styles => { :original => ["1000x1000",:jpg],:thumb => ["100x100#",:jpg]},
    :path => ":rails_root/public/profile/:id/:style/:filename",
    :url  => "/profile/:id/:style/:filename",
    default_url: "/missing.png"
  validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/png', 'image/gif']
    geocoded_by :address
  after_validation :geocode


  def admin?
  self.role.name == "Admin"
  end

  def member?
  self.role.name == "Member"
  end

  def guest?
    self.role.name =="Guest"
  end  

  private
  def set_default_role
    self.role ||= Role.find_by_name('Member')
  end

end