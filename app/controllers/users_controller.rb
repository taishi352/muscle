class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :correct_user, only: [:edit, :update]

	def index
		@users = User.all.page(params[:page])
	end

	def show
		# TODO: scoringのcreate操作をshowアクションで行うかは要検討
		if params[:start_date].nil? && current_user.scorings.where(start_time: Date.current.beginning_of_month.strftime("%Y-%m-%d %H:%M:%S")).empty?
			head = Date.current.beginning_of_month
			tail = Date.current.end_of_month
			(head..tail).each do |month_day|
				@scoring = Scoring.new(:exercise_result => 0, :meal_result => false, :start_time => month_day)
				@scoring.user_id = current_user.id
				@scoring.save
			end
		elsif !params[:start_date].nil? && current_user.scorings.where(start_time: params[:start_date] + " 00:00:00").empty?
			head = Date.parse(params[:start_date]).beginning_of_month
			tail = Date.parse(params[:start_date]).end_of_month
			(head..tail).each do |month_day|
				@scoring = Scoring.new(:exercise_result => 0, :meal_result => false, :start_time => month_day)
				@scoring.user_id = current_user.id
				@scoring.save
			end
		end

		@scorings = current_user.scorings
		@scoring = Scoring.new
		@user = User.find(params[:id])
		@posts = @user.posts

		start_month = Time.current.ago(30.days)
		end_month = Time.current
		@chart = current_user.scorings.where(start_time: start_month..end_month)
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if  @user.update(user_params)
			redirect_to user_path(current_user.id), notice: "変更しました!"
		else
			render 'edit'
		end
	end

	def follows
    @user  = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
  end

	private
	def user_params
      params.require(:user).permit(:name, :introduction, :profile_image, :exercise_rule, :meal_rule, :penalty)
    end

    def correct_user
        @user = User.find(params[:id])
        if @user.id != current_user.id
           redirect_to user_path(current_user.id)
        end
    end
end
