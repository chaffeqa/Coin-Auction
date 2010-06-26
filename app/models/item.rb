class Item < ActiveRecord::Base
  belongs_to :product, :polymorphic => true
  has_one :auction

  
end
