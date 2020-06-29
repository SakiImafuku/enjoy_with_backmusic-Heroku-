require 'rails_helper'

describe 'musicpost', type: :system, js: true do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:musicpost_a) { create(:musicpost, title: 'テストA') }
  let!(:musicpost_b) { create(:musicpost, title: 'テストB') }
  let!(:musicpost_c) { create(:musicpost, title: 'テストC') }

  before do
    login_for_system(user_a)
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
