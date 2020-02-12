class Scoring < ApplicationRecord

	belongs_to :user

	# グラフ作成時enumが原因のエラーが発生したためenumを使用しない
	#enum exercise_result: {未実施: 0, 少しできた: 1, いつも通り: 2, めっちゃできた: 3}

	def meal_result_str
        self.meal_result ? "達成" : "未達成"
	end
end
