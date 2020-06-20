require 'rails_helper'

describe 'ユーザー', type: :system, js: true do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, name: 'テストユーザー2', email: 'test2@example.com') }

  context '新規会員登録' do
    it '新規会員登録に成功する' do
      visit new_user_registration_path
      expect {
        fill_in "名前", with: 'test'
        fill_in "メールアドレス", with: 'test@example.com'
        fill_in "パスワード", with: 'password'
        fill_in "確認用パスワード", with: 'password'
        click_button '登録'
        expect(current_path).to eq root_path
        expect(page).to have_content 'アカウント登録が完了しました。'
      }.to change(User, :count).by(1)
    end

    it '新規会員登録に失敗する' do
      visit new_user_registration_path
      fill_in "名前", with: ''
      fill_in "メールアドレス", with: 'test1@example.com'
      fill_in "パスワード", with: 'password'
      fill_in "確認用パスワード", with: 'pass'
      click_button '登録'
      expect(current_path).to eq '/users'
      expect(page).to have_content '名前が入力されていません。'
      expect(page).to have_content 'メールアドレスは既に使用されています。'
      expect(page).to have_content '確認用パスワードが内容とあっていません。'
    end
  end

  context 'ユーザーページ' do
    before do
      login_for_system(user)
      visit user_path(user)
    end

    it 'ユーザーページに名前が表示される' do
      expect(page).to have_content user.name
    end

    it 'ユーザー情報を編集する' do
      click_button 'ユーザー情報編集'
      fill_in "名前", with: "test_edit"
      fill_in "自己紹介", with: "Hello!"
      click_button "変更する"
      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'ユーザー情報を更新しました'
      expect(page).to have_content 'test_edit'
      expect(page).to have_content 'Hello!'
    end

    it '自己紹介は入力しない' do
      click_button 'ユーザー情報編集'
      fill_in "名前", with: "test_edit"
      fill_in "自己紹介", with: ""
      click_button "変更する"
      expect(current_path).to eq user_path(user)
      expect(page).to have_content 'ユーザー情報を更新しました'
      expect(page).to have_content 'test_edit'
    end

    it 'ユーザー情報の編集に失敗する' do
      click_button 'ユーザー情報編集'
      fill_in "名前", with: ""
      fill_in "自己紹介", with: "a" * 301
      click_button "変更する"
      expect(page).to have_content '名前が入力されていません。'
      expect(page).to have_content '自己紹介は300文字以下に設定して下さい。'
    end

    it '他のユーザーのユーザー情報を編集できない' do
      visit user_path(user2.id)
      expect(page).not_to have_content 'ユーザー情報編集'
    end
  end

  context 'パスワード変更' do
    before do
      login_for_system(user)
      visit settings_path
      click_link "パスワードを変更する"
    end

    it 'パスワードを変更する' do
      fill_in "現在のパスワード", with: 'password'
      fill_in "パスワード", with: 'changepass'
      fill_in "確認用パスワード", with: 'changepass'
      click_button "変更"
      expect(current_path). to eq '/'
      expect(page).to have_content 'パスワードを変更しました'
    end

    it '現在のパスワードに誤りがある場合' do
      fill_in "現在のパスワード", with: 'pass'
      fill_in "パスワード", with: 'changepass'
      fill_in "確認用パスワード", with: 'changepass'
      click_button "変更"
      expect(current_path). to eq edit_user_registration_password_path
      expect(page).to have_content '現在のパスワードが一致しません。'
    end

    it '新しいパスワードに誤りがある場合' do
      fill_in "現在のパスワード", with: 'password'
      fill_in "パスワード", with: 'changepass'
      fill_in "確認用パスワード", with: 'pass'
      click_button "変更"
      expect(current_path). to eq edit_user_registration_password_path
      expect(page).to have_content '確認用パスワードが内容とあっていません。'
    end
  end

  context 'メールアドレスの変更' do
    before do
      login_for_system(user)
      visit settings_path
    end

    it 'メールアドレスを変更する' do
      fill_in "change_email", with: "change@example.com"
      click_button "変更する"
      expect(current_path).to eq settings_path
      expect(page).to have_content "メールアドレスを変更しました"
      expect(User.find(user.id).email).to eq "change@example.com"
    end
    it 'メールアドレスがすでに使用されている場合' do
      fill_in "change_email", with: 'test2@example.com'
      click_button "変更する"
      expect(page).to have_content "メールアドレスは既に使用されています。"
    end
  end

  context 'アカウントの削除' do
    before do
      login_for_system(user)
      visit settings_path
    end

    it 'アカウントを削除する' do
      expect {
        accept_confirm("アカウントを削除します。本当によろしいですか？") do
          click_link 'アカウントを削除する'
        end
        expect(page).to have_content '新規登録'
      }.to change(User, :count).by(-1)
    end
  end
end
