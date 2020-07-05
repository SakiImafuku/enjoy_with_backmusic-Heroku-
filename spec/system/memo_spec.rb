require 'rails_helper'

describe 'Memo', type: :system, js: true do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:musicpost) { create(:musicpost) }
  let!(:taxonomy_composer) { create(:taxonomy, name: "作曲家", position: 1) }
  let!(:taxonomy_instrument) { create(:taxonomy, name: "演奏楽器", position: 2) }

  before do
    login_for_system(user_a)
  end

  it 'メモする／削除する' do
    visit musicpost_path(musicpost.id)
    click_link 'メモ'
    fill_in 'memo', with: 'テストです'
    click_button '作成'
    within '.memo_field' do
      expect(page).to have_content 'テストです'
    end
    click_button '編集'
    fill_in 'memo_memo', with: '変更しました'
    click_button '更新'
    within '.memo_field' do
      expect(page).to have_content '変更しました'
    end
    click_button '削除'
    within '.memo_field' do
      expect(page).not_to have_content '変更しました'
    end
  end

  it '他のユーザーがメモを見ることはできない' do
    visit musicpost_path(musicpost.id)
    click_link 'メモ'
    fill_in 'memo', with: 'テストです'
    click_button '作成'
    within 'header' do
      click_link user_a.name
    end
    click_link 'ログアウト'
    login_for_system(user_b)
    visit musicpost_path(musicpost.id)
    click_link 'メモ'
    within '.memo_field' do
      expect(page).not_to have_content 'テストです'
      expect(page).to have_button '作成'
    end
  end
end
