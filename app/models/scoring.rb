class Scoring < ApplicationRecord

	belongs_to :user

	enum exercise_result: {未実施: 0, 少しできた: 1, いつも通り: 2, めっちゃできた: 3}

	def meal_result_str
        self.meal_result ? "達成" : "未達成"
	end
end
