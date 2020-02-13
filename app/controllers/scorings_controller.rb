class ScoringsController < ApplicationController
	
	def edit
		@scoring = Scoring.find(params[:id])
	end
	def update
		@scoring = Scoring.find(params[:id])
		@scoring.update(scoring_params)
		redirect_to user_path(@scoring.user.id)
	end

	private
	def scoring_params
      params.require(:scoring).permit(:user_id, :exercise_result, :meal_result, :start_time)
    end
end
