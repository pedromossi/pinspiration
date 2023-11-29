# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  description :string
#  image       :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :integer
#
class Photo < ApplicationRecord
  belongs_to :creator, required: true, class_name: "User", foreign_key: "creator_id"
  has_many  :pins, class_name: "Pin", foreign_key: "photo_id", dependent: :destroy
  has_many  :comments, class_name: "Comment", foreign_key: "photo_id", dependent: :destroy
  has_many :pinners, through: :pins, source: :pinner
end
