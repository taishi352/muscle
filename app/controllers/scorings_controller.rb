class ScoringsController < ApplicationController
	def new
		@scoring = Scoring.new
	end
	def create
		# if Date.current == Date.current.beginning_of_month
		@scoring = Scoring.new(scoring_params)
		@scoring.user_id = current_user.id
		@scoring.save
		redirect_to user_path(@scoring.id)
	end
	def edit
		@scoring = Scoring.find(params[:id])
	end
	def update
		@scoring = Scoring.find(params[:id])
		@scoring.update(scoring_params)
		redirect_to user_path(@scoring.id)
	end

	private
	def scoring_params
      params.require(:scoring).permit(:user_id, :exercise_result, :meal_result, :start_time)
    end
end
