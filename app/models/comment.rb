# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  text         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  commenter_id :integer
#  photo_id     :integer
#
class Comment < ApplicationRecord
  validates :text, presence: true

  belongs_to :commenter, required: true, class_name: "User", foreign_key: "commenter_id"
  belongs_to :photo, required: true, class_name: "Photo", foreign_key: "photo_id"
end
