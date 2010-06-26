class HomeController < ApplicationController
  def index
    @announcements = Announcement.recent_10
  end

  def announcement
    @announcement = Announcement.find(params[:id])
  end

  def all_announcements
    @announcements = Announcement.recent_first
  end

end
