require 'rails_helper'

describe 'Relationship', type: :system, js: true do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user, name: 'テストユーザー2', email: 'test2@example.com') }
  let!(:user3) { create(:user, name: 'テストユーザー3', email: 'test3@example.com') }

  before do
    login_for_system(user)
  end

  it 'フォローする' do
    visit user_path(user2.id)
    click_button 'フォローする'
    expect(page).to have_button 'フォロー中'
    within '#followers' do
      expect(page).to have_content 1
    end
    click_link 'followers'
    within '.user_relationship' do
      expect(page).to have_content user.name
    end
    visit user_path(user)
    within '#following' do
      expect(page).to have_content 1
    end
  end

  it 'フォロー解除する' do
    user.follow(user2)
    user3.follow(user2)
    visit user_path(user2.id)
    expect(page).to have_button 'フォロー中'
    click_button 'フォロー中'
    expect(page).to have_button 'フォローする'
    within '#followers' do
      expect(page).to have_content 1
    end
    click_link 'followers'
    within '.user_relationship' do
      expect(page).not_to have_content user.name
    end
    visit user_path(user)
    within '#following' do
      expect(page).to have_content 0
    end
  end

  it 'フォロー一覧ページからフォローする' do
    user2.follow(user3)
    visit following_user_path(user2)
    find('.user_relationship').hover
    find('.btn').click
    visit user_path(user)
    within '#following' do
      expect(page).to have_content 1
    end
    visit user_path(user3)
    within '#followers' do
      expect(page).to have_content 2
    end
  end
end
