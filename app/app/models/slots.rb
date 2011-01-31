class Slots < ActiveRecord::Base
  belongs_to :hours

  attr_accessible :email
end
