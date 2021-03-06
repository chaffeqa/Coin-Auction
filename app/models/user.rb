class User < ActiveRecord::Base
  acts_as_authentic do |c|
    #    c.my_config_option = my_value # for available options see documentation in: Authlogic::ActsAsAuthentic
  end # block optional
  has_many :bids

  validates_presence_of :login
  validates_uniqueness_of :login

end
