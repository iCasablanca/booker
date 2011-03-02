class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.require_password_confirmation = false
  end
  has_one :google, :class_name=>"GoogleToken", :dependent=>:destroy 
end
