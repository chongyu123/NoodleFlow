class Event < ActiveRecord::Base
  belongs_to :user, :foreign_key => "source_id"
  belongs_to :organization
  
  def self.top_events
    includes(:user).limit(10).order("created_at DESC")
  end
  
  #delegate :user_name, :image_name, :to => :user
  
  
end
