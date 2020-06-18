# require 'rails_helper'

# describe 'musicpost', type: :system do
#   let!(:user_a) { create(:user) }
#   let!(:taxonomy_composer) { create(:taxonomy, name: '作曲家', position: 1) }
#   let!(:taxonomy_instrument) { create(:taxonomy, name: '演奏楽器', position: 2) }
#   let!(:taxon_a) { create(:taxon, name: "morzart", taxonomy: taxonomy_composer) }  
#   let!(:taxon_b) { create(:taxon, name: "violin", taxonomy: taxonomy_instrument) }  
#   before do
#     visit new_user_session_path
#     fill_in 'メールアドレス', with: 'test1@example.com'
#     fill_in 'パスワード', with: 'password'
#     click_button 'ログイン'
#   end
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
# end