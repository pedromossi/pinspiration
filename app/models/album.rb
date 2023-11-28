# == Schema Information
#
# Table name: albums
#
#  id          :integer          not null, primary key
#  description :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :integer
#
class Album < ApplicationRecord
  belongs_to :creator, required: true, class_name: "User", foreign_key: "creator_id"
  has_many  :photos, class_name: "Photo", foreign_key: "album_id", dependent: :destroy
end
