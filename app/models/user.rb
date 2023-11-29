# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  bio                    :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many  :photos, class_name: "Photo", foreign_key: "creator_id", dependent: :destroy
  has_many  :pins, class_name: "Pin", foreign_key: "pinner_id", dependent: :destroy
  has_many  :comments, class_name: "Comment", foreign_key: "commenter_id", dependent: :destroy
  has_many  :albums, class_name: "Album", foreign_key: "creator_id", dependent: :destroy
end
