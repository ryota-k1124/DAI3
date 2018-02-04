class Instagram < ActiveRecord::Base
    validates_presence_of :image, :title
    belongs_to :user
    has_many :comments, dependent: :destroy
    mount_uploader :image, PictureUploader
end
