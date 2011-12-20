class Pad < ActiveRecord::Base
  belongs_to :organization
  
  has_many :pages, :dependent => :destroy
  has_many :conversations, :dependent => :destroy
  has_many :attachments, :dependent => :destroy
  has_many :permissions, :dependent => :destroy
  has_many :users, :through => :permissions

  def allow_collaborate( user_id )
    permission = permissions.first( :conditions => {:user_id => user_id} )
    if permission != nil
      (permission.status == Permission::STAT_OWNER) || \
      (permission.status == Permission::STAT_ADMIN) || \
      (permission.status == Permission::STAT_MEMBER)
    else
      false
    end
    #true #testing
  end
  
  def allow_permission( user_id )
    permission = permissions.first( :conditions => {:user_id => user_id} )
    if permission != nil
      (permission.status == Permission::STAT_OWNER) || \
      (permission.status == Permission::STAT_ADMIN)
    else
      false
    end
  end

  def allow_delete( user_id )
    permission = permissions.first( :conditions => {:user_id => user_id} )
    if !permission.nil?
      permission.status == Permission::STAT_OWNER
    else
      false
    end
    #true  #testing
  end

  def tab_counts
    tabs = Hash.new
    tabs[:page] = pages.count
    tabs[:conversation] = conversations.count
    tabs[:attachment] = attachments.count
    return tabs
  end
end
