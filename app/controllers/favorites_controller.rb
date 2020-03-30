class FavoritesController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@favorite = current_user.favorites.new(post_id: @post.id)
		@favorite.save
		# redirect_back(fallback_location: root_path)
	end
	def destroy
		@post = Post.find(params[:post_id])
		@favorite = current_user.favorites.find_by(post_id: @post.id)
		@favorite.destroy
		# redirect_back(fallback_location: root_path)
	end

	private
  def redirect
    case params[:redirect_id].to_i
    when 0
      redirect_to posts_path
    when 1
      redirect_to post_path(@post)
    end
  end
end
