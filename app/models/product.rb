class Product < ApplicationRecord
  mount_uploader :image, ImageUploader
  # mount_uploader :avatar, AvatarUploader
end
