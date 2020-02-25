require 'rails_helper'

RSpec.describe 'PostCommentモデルのテスト', type: :model do
	describe 'バリデーションのテスト' do
	  	let!(:post_comment) { FactoryBot.build(:post_comment) }

	  	context 'commentカラム' do
	    	it '空欄でないこと' do
			    post_comment.comment = ''
			    expect(post_comment.valid?).to eq false;
	    	end
	    end
	end

	describe 'アソシエーションのテスト' do
	    context 'Genreモデルとの関係' do
		    it '1:Nとなっている' do
		    	expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
		    end
	    end
	end
end
