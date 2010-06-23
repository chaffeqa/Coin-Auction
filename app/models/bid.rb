class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :item

  validate :ammount_greater_than_zero

  protected
  def amount_greater_than_zero
    errors.add(:amount, "should be at least 0.01") if amount.nil? || amount < 0.01
  end

end
