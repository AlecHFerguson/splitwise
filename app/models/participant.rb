class Participant < ActiveRecord::Base
  belongs_to :tab
  has_one :user
end
