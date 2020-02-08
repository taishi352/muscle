class Scoring < ApplicationRecord

	belongs_to :user

	enum exercise_result: {未実施: 0, 少し: 1, いつも通り: 2, めっちゃできた: 3}

	def meal_result_str
        self.meal_result ? "できた" : "できなかった"
	end
end
