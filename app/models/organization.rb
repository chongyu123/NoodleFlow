class Organization < ActiveRecord::Base
  has_many :pads  #, :dependent => :destroy
  has_many :users #, :dependent => :destroy
  has_many :events #, :dependent => :destroy
end
