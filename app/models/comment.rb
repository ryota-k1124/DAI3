class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :instagram
  has_many :notifications, dependent: :destroy
end
