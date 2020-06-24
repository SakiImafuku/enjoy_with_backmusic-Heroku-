require 'rails_helper'

describe 'Comment', type: :system, js: true do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:musicpost) { create(:musicpost) }
  let!(:taxonomy_composer) { create(:taxonomy, name: "作曲家", position: 1) }
  let!(:taxonomy_instrument) { create(:taxonomy, name: "演奏楽器", position: 2) }

  before do
    login_for_system(user_a)
  end

  it 'コメントする／削除する' do
    visit musicpost_path(musicpost.id)
    fill_in 'content', with: 'テストです'
    click_button 'コメント'
    within '.comment_index' do
      expect(page).to have_content user_a.name
      expect(page).to have_content 'テストです'
    end
    click_button 'trash_comment'
    within '.comment_index' do
      expect(page).not_to have_content user_a.name
      expect(page).not_to have_content 'テストです'
    end
  end

  it '他のユーザーがコメントを消すことはできない' do
    visit musicpost_path(musicpost.id)
    fill_in 'content', with: 'テストです'
    click_button 'コメント'
    click_link 'header_other'
    click_link 'Signout'
    login_for_system(user_b)
    visit musicpost_path(musicpost.id)
    within '.comment_index' do
      expect(page).to have_content user_a.name
      expect(page).to have_content 'テストです'
      expect(page).not_to have_button 'trash_comment'
    end
  end
end
