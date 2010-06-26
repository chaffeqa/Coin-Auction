class Auction < ActiveRecord::Base
  has_many :bids
  belongs_to :item

  scope :category_group, joins(:item).order("item.series desc").includes(:item)
  scope :list_by_time_left, order("end_time desc").includes(:item)
  scope :list_by_cheapest, order("current_bid asc").includes(:item)
  scope :list_by_most_expensive, order("current_bid desc").includes(:item)
  scope :list_by_name, order("name desc").includes(:item)
  scope :list_by_popularity, joins(:bids).group('auctions.id').order("count(bids.id) desc").includes(:item)
end
