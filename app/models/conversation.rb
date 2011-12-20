class Conversation < ActiveRecord::Base
  belongs_to :pad
  has_many :messages, :dependent => :destroy, :include => :user
end