require 'rails_helper'

describe 'Before_login', type: :system, js: true do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:musicpost_a) { create(:musicpost, title: 'テストA', user_id: user_a.id) }
  let!(:taxonomy_composer) { create(:taxonomy, name: "作曲家", position: 1) }
  let!(:taxonomy_instrument) { create(:taxonomy, name: "演奏楽器", position: 2) }

  it 'コメントしようとする' do
    visit root_url
    within 'header' do
      expect(page).to have_content "新規登録"
      expect(page).to have_content "ログイン"
    end
    click_link musicpost_a.title
    expect(current_path).to eq musicpost_path(musicpost_a)
    expect(page).to have_content musicpost_a.title
    fill_in 'content', with: 'テストです'
    click_button 'コメント'
    expect(page).to have_content "アカウント登録もしくはログインしてください。"
  end

  it "メモを利用しようとする" do
    visit root_url
    click_link musicpost_a.title
    click_link "メモ"
    expect(page).to have_content "アカウント登録もしくはログインしてください。"
  end

  it "お気に入りボタンを押す" do
    visit root_url
    within "#favorite_form_#{musicpost_a.id}" do
      find('.unfavorite').click
    end
    expect(page).to have_content "アカウント登録もしくはログインしてください。"
  end
end
