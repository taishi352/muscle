require 'rails_helper'

RSpec.describe 'Genreモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let!(:genre) { FactoryBot.build(:genre) }

    context 'genre_nameカラム' do
      it '空欄でないこと' do
        genre.genre_name = ''
        expect(genre.valid?).to eq false;
      end
    end
    describe 'アソシエーションのテスト' do
    context 'Genreモデルとの関係' do
      it '1:Nとなっている' do
        expect(Genre.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
  end
end
