class Notification < ActiveRecord::Base
  belongs_to :comment
  belongs_to :information
  belongs_to :event
end
