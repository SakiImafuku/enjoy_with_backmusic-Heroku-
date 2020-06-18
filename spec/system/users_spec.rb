require 'rails_helper'

describe 'ユーザー', type: :system do
  it '新規会員登録する' do
    visit new_user_registration_path
    fill_in "名前", with: 'test'
    fill_in "メールアドレス", with: 'test@example.com'
    fill_in "パスワード", with: 'password'
    fill_in "確認用パスワード", with: 'password'
    click_button '登録'
    expect(current_path).to eq root_path
  end
end
