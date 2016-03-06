class Comment < ActiveRecord::Base
  belongs_to :wine
  belongs_to :user
end
