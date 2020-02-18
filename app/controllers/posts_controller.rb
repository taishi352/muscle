class PostsController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_post, only: [:edit, :update]

	def index
		@all = Post.all.page(params[:page])

		@genres = Genre.all
	    # urlにgenre_id(params)がある場合
	    if params[:genre_id]
	      # genreのデータベースのテーブルから一致するidを取得
	      @genre = Genre.find(params[:genre_id])
	      # genre_idと紐づく投稿を取得
	      @posts = @genre.posts.order(created_at: :asc).reverse_order.page(params[:page])
	      @count = Post.where(genre_id: @genre.id).count
	    # urlにgenre_id(params)がない場合
	    else
	      # 投稿すべてを取得
	      @posts = Post.order(created_at: :asc).reverse_order.page(params[:page])
	      @count = Post.all.count
	    end
	end
	def show
		@post = Post.find(params[:id])
		@post_comment = PostComment.new
	end
	def new
		@post = Post.new
	end
	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if  @post.save
			redirect_to post_path(@post.id), notice: "投稿しました!"
		else
	  		render 'new'
  		end
	end
	def edit
		@post = Post.find(params[:id])
	end
	def update
		@post = Post.find(params[:id])
		if  @post.update(post_params)
			redirect_to post_path(@post.id), notice: "変更しました!"
		else
	  		render 'edit'
  		end
	end
	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end

	private
	def post_params
		params.require(:post).permit(:genre_id, :title, :body, :post_image)
	end

	def correct_post
		@post = Post.find(params[:id])
		if @post.user.id != current_user.id
			redirect_to posts_path
		end
	end
end