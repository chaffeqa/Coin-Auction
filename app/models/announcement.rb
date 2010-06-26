class Announcement < ActiveRecord::Base
  scope :recent_first, order("created_at desc")
  scope :recent_10, recent_first.limit(5)
end
