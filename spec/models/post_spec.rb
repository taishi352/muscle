require 'rails_helper'

RSpec.describe 'Postモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { FactoryBot.create(:user) }
    let!(:post) { FactoryBot.build(:post, user_id: user.id) }
    let!(:genre) { FactoryBot.build(:genre) }

    context 'titleカラム' do
      it '空欄でないこと' do
        post.title = ''
        expect(post.valid?).to eq false;
      end
    end
    context 'bodyカラム' do
      it '空欄でないこと' do
        post.body = ''
        expect(post.valid?).to eq false;
      end
      it '200文字以下であること' do
        post.body = Faker::Lorem.characters(number:201)
        expect(post.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Genreモデルとの関係' do
      it 'N:1となっている' do
        expect(Post.reflect_on_association(:gebre).macro).to eq :belongs_to
      end
    end
  end
end