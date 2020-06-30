require 'rails_helper'

describe 'Musicpost', type: :system, js: true do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:musicpost_a) { create(:musicpost, title: 'テストA', user_id: user_a.id) }
  let!(:musicpost_b) { create(:musicpost, title: 'テストB', user_id: user_a.id) }
  let!(:musicpost_c) { create(:musicpost, title: 'テストC', user_id: user_b.id) }
  let!(:taxonomy_composer) { create(:taxonomy, name: "作曲家", position: 1) }
  let!(:taxonomy_instrument) { create(:taxonomy, name: "演奏楽器", position: 2) }

  before do
    login_for_system(user_a)
  end

  it '投稿を削除する(TOPページ)' do
    within all('.musicpost')[2] do
      accept_confirm("削除しますか？") do
        click_button 'trash_musicpost'
      end
    end
    expect(page).to have_content '投稿を削除しました'
    expect(page).not_to have_content musicpost_a.title
    expect(current_path).to eq '/'
  end

  it '投稿を削除する(詳細ページ)' do
    click_link musicpost_a.title
    accept_confirm("削除しますか？") do
      click_button 'trash_musicpost'
    end
    expect(page).to have_content '投稿を削除しました'
    expect(page).not_to have_content musicpost_a.title
    expect(current_path).to eq '/'
  end

  it '投稿を削除する(ユーザーページ)' do
    visit user_path(user_a)
    within all('.musicpost')[0] do
      accept_confirm("削除しますか？") do
        click_button 'trash_musicpost'
      end
    end
    expect(page).to have_content '投稿を削除しました'
    expect(page).not_to have_content musicpost_a.title
    expect(current_path).to eq user_path(user_a)
  end

  it '他のユーザーの投稿は削除できない' do
    within all('.musicpost')[0] do
      expect(page).not_to have_button 'trash_musicpost'
    end
  end


  it '並び替える' do
    user_a.favorite(musicpost_a)
    user_a.favorite(musicpost_b)
    user_b.favorite(musicpost_a)
    within first('.musicpost') do
      expect(page).to have_content musicpost_c.title
    end
    select '人気順', from: 'order_select'
    sleep 5
    within first('.musicpost') do
      expect(page).to have_content musicpost_a.title
    end
  end

#   it '投稿する' do
#     context '入力不備がある場合' do
#       visit new_upload_musicpost_path
#       attach_file 'Audio', 'app/assets/audio/test.m4a'
#       fill_in 'Composer', with: 'morzart'
#       fill_in 'Instrument', with: 'violin'
#       fill_in 'Overview', with: 'Hello!'
#       click_button '投稿'
#       expect(current_path).to eq new_upload_musicpost_path
#       expect(page),to have_content 'Titleが入力されていません。'
#     end
#     context '既存のTaxonを使用してアップロードに成功する場合' do
#       attach_file 'Audio', 'app/assets/audio/test.m4a'
#       fill_in 'Title', with: 'test'
#       expect
#       expect(current_path).to eq root_path
#       expect(page).to have_content 'test'

#     end

#   end
end
