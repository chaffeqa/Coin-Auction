class Item < ActiveRecord::Base
  belongs_to :product, :polymorphic => true
  has_many :auctions, :dependent => :destroy

  validates_presence_of :name
end
