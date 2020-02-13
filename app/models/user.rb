class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :scorings, dependent: :destroy
  has_many :posts, dependent: :destroy

  attachment :profile_image

  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 140}
  validates :exercise_rule, length: {maximum: 50}
  validates :meal_rule, length: {maximum: 50}
  validates :penalty, length: {maximum: 50}
end
