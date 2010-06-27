include ActionView::Helpers::NumberHelper
class Auction < ActiveRecord::Base
  has_many :bids, :dependent => :destroy
  belongs_to :item

  validates_presence_of :starting_amount, :item_id, :end_time
  validates_numericality_of :starting_amount, :greater_than_or_equal_to => 0
  validates_presence_of :current_bid, :on => :update
  validates_numericality_of :current_bid, :on => :update
  
  after_create {|auction| auction.current_bid = auction.starting_amount if auction.current_bid.blank?}

  scope :category_group, joins(:item).order("item.series desc").includes(:item)
  scope :list_by_time_left, order("end_time desc").includes(:item)
  scope :list_by_cheapest, order("current_bid asc").includes(:item)
  scope :list_by_most_expensive, order("current_bid desc").includes(:item)
  scope :list_by_name, order("name desc").includes(:item)
  scope :list_by_popularity, joins(:bids).group('auctions.id').order("count(bids.id) desc").includes(:item)


  def current_bid_to_currency
    number_to_currency(self.current_bid)
  end

  def time_left_long
    t1 = Time.parse(self.end_time.to_s)
    t2 = Time.parse(Time.now.to_s)
    tl = t1 - t2
    if tl < 0
      return "Ended"
    end
    parse_time_left_long(tl)
  end

  def time_left_short
    t1 = Time.parse(self.end_time.to_s)
    t2 = Time.parse(Time.now.to_s)
    tl = t1 - t2
    if tl < 0
      return "Ended"
    end
    parse_time_left_short(tl)
  end


  def update_highest_bid
    if self.bids > 1
      max = self.bids.maximum("amount")
      max_bid = self.bids.where("amount == ?", max)
      self.update_attributes(:current_bid => max, :top_bidder => max_bid.first.user.login)
    else
      self.update_attributes(:current_bid => self.starting_amount, :top_bidder => "")
    end
  end


  
  private

  

  def parse_time_left_long(time)
    s=""
    seconds = (time%(60)).to_i
    minutes = ((time%(60*60))/60).to_i
    hours = (time%(60*60*24)/(60*60)).to_i
    days = (time/(60*60*24)).to_i
    s << "#{days} day#{'s' if days > 1}, " if days > 0
    s << "#{hours} hr#{'s' if hours > 1}, " if hours > 0
    s << "#{minutes} min#{'s' if minutes > 1}, " if minutes > 0
    s << "#{seconds} sec" if seconds > 0
    return s
  end

  def parse_time_left_short(time)
    s="Error"
    seconds = (time%(60)).to_i
    minutes = ((time%(60*60))/60).to_i
    hours = (time%(60*60*24)/(60*60)).to_i
    days = (time/(60*60*24)).to_i
    if days > 0
      s = "#{days} day#{'s' if days > 1}, " if days > 0
      s << "#{hours} hr#{'s' if hours > 1}" if hours > 0
    else
      s = "#{hours} hr#{'s' if hours > 1}, " if hours > 0
      s << "#{minutes} min#{'s' if minutes > 1}, " if minutes > 0
      s << "#{seconds} sec" if seconds > 0
    end
    return s
  end
end


#  def time_left_long(end_datetime, current_datetime=Time.now)
#    t1 = Time.parse(end_datetime.to_s)
#    t2 = Time.parse(current_datetime.to_s)
#    tl = t1 - t2
#    if tl < 0
#      return "Ended"
#    end
#    parse_time_left_long(tl)
#  end