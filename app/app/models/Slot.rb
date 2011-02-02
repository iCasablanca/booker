class Slot < ActiveRecord::Base
  belongs_to :hour

  attr_accessible :email
end
