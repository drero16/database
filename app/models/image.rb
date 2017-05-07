class Image < ActiveRecord::Base
  belongs_to :animal
  belongs_to :pet
  belongs_to :event
  belongs_to :information
  belongs_to :user
  belongs_to :adoption
  belongs_to :risk

  has_attached_file :image,
:styles => { :original => ["1000x1000",:jpg],:thumb => ["100x100#",:jpg]},
    :path => ":rails_root/public/images/:id/:style/:filename",
    :url  => "/images/:id/:style/:filename"
  

validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png', 'image/gif']
  validates_attachment_presence :image

end




