require 'rails_helper'

describe '投稿のテスト' do
  let(:user) { FactoryBot.create(:user) }
  let!(:user2) { FactoryBot.create(:user) }
  let!(:genre) { FactoryBot.create(:genre) }
  let!(:post) { FactoryBot.create(:post, user: user, genre: genre) }
  let!(:post2) { FactoryBot.create(:post, user: user2,  genre: genre) }
  before do
  	visit new_user_session_path
  	fill_in 'user[email]', with: user.email
  	fill_in 'user[password]', with: user.password
  	click_button 'ログイン'
  end
  describe '投稿のテスト' do
		context '表示の確認' do
		  it '投稿に成功する' do
        visit new_post_path
		  	fill_in 'post[title]', with: Faker::Lorem.characters(number:5)
		  	fill_in 'post[body]', with: Faker::Lorem.characters(number:20)
		  	click_button '投稿する'
		  	expect(page).to have_content '投稿しました!'
		  end
		  it '投稿に失敗する' do
        visit new_post_path
		  	click_button '投稿する'
		  	expect(page).to have_content 'エラー'
		  	expect(current_path).to eq('/posts')
		  end
		end
  end

  describe '編集のテスト' do
  	context '自分の投稿の編集画面への遷移' do
  	  it '遷移できる' do
	  		visit edit_post_path(post)
	  		expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
	  	end
	  end
		context '他人の投稿の編集画面への遷移' do
		  it '遷移できない' do
		    visit edit_post_path(post2)
		    expect(current_path).to eq('/posts')
		  end
		end
		context '表示の確認' do
			before do
				visit edit_post_path(post)
			end
			it '投稿編集画面と表示される' do
				expect(page).to have_content('投稿編集画面')
			end
			it 'タイトル編集フォームが表示される' do
				expect(page).to have_field 'post[title]', with: post.title
			end
			it '内容編集フォームが表示される' do
				expect(page).to have_field 'post[body]', with: post.body
			end
		end
		context 'フォームの確認' do
			it '編集に成功する' do
				visit edit_post_path(post)
				click_button '編集する'
				expect(page).to have_content '変更しました'
				expect(current_path).to eq '/posts/' + post.id.to_s
			end
			it '編集に失敗する' do
				visit edit_post_path(post)
				fill_in 'post[title]', with: ''
				click_button '編集する'
				expect(page).to have_content 'エラー'
				expect(current_path).to eq '/posts/' + post.id.to_s
			end
		end
	end

  describe '一覧画面のテスト' do
  	before do
  		visit posts_path
  	end
  	context '表示の確認' do
  		it 'All Postsと表示される' do
  			expect(page).to have_content 'All Posts'
  		end
  		it '自分と他人のタイトルのリンク先が正しい' do
  			expect(page).to have_link post.title, href: post_path(post)
  			expect(page).to have_link post2.title, href: post_path(post2)
  		end
  	end
  end

  describe '詳細画面のテスト' do
  	context '自分・他人共通の投稿詳細画面の表示を確認' do
  		it 'Detailと表示される' do
  			visit post_path(post)
  			expect(page).to have_content 'Detail'
  		end
  		it '投稿のタイトルが表示される' do
  			visit post_path(post)
  			expect(page).to have_content post.title
  		end
  		it '投稿の内容が表示される' do
  			visit post_path(post)
  			expect(page).to have_content post.body
  		end
  	end
  	context '自分の投稿詳細画面の表示を確認' do
  		it '投稿の編集リンクが表示される' do
  			visit post_path post
  			expect(page).to have_link '編集', href: edit_post_path(post)
  		end
  		it '投稿の削除リンクが表示される' do
  			visit post_path post
  			expect(page).to have_link '削除', href: post_path(post)
  		end
  	end
  	context '他人の投稿詳細画面の表示を確認' do
  		it '投稿の編集リンクが表示されない' do
  			visit post_path(post2)
  			expect(page).to have_no_link '編集', href: edit_post_path(post2)
  		end
  		it '投稿の削除リンクが表示されない' do
  			visit post_path(post2)
  			expect(page).to have_no_link '削除', href: post_path(post2)
  		end
  	end
  end
end