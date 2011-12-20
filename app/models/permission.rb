class Permission < ActiveRecord::Base
  belongs_to :user
  belongs_to :pad
  
  STAT_OWNER = 1
  STAT_ADMIN = 2
  STAT_MEMBER = 3
  STAT_FOLLOWER = 4
  
  def status_name
    case status
      when STAT_OWNER
        'owner'
      when STAT_ADMIN
        'admin'
      when STAT_MEMBER
        'member'
      when STAT_FOLLOWER
        'follower'
      end
  end
end
