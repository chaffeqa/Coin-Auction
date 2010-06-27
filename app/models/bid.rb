include ActionView::Helpers::NumberHelper
class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :auction

  validates_associated :user, :auction
  validates_presence_of :amount
  validate :amount_greater_than_zero
  validate :update_auction_bid

  after_destroy :update_auction_high_bid

  
  def amount_to_currency
    number_to_currency(self.amount)
  end

  protected

  def update_auction_high_bid
    if self.auction
      self.auction.update_highest_bid
    end
  end
  
  def amount_greater_than_zero
    errors.add(:amount, "should be at least 0.01") if amount.nil? || amount < 0.01
  end

  def update_auction_bid
    unless self.amount > self.auction.current_bid and self.auction.update_attributes(:current_bid => self.amount, :top_bidder => self.user.login)
      errors.add(:amount, "needs to be greater than the current bid of #{self.auction.current_bid_to_currency}.")
    end
  end

end
