class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@scorings = Scoring.all
	end
end
