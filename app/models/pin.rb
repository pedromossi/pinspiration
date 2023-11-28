# == Schema Information
#
# Table name: pins
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  photo_id   :integer
#  pinner_id  :integer
#
class Pin < ApplicationRecord
  belongs_to :pinner, required: true, class_name: "User", foreign_key: "pinner_id"
  belongs_to :photo, required: true, class_name: "Photo", foreign_key: "photo_id"
end
