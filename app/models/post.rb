class Post < ApplicationRecord

	belongs_to :user
	belongs_to :genre

	has_many :favorites, dependent: :destroy
	has_many :post_comments, dependent: :destroy

	attachment :post_image

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
