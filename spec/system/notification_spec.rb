require 'rails_helper'

describe 'Notification', type: :system, js: true do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:user_c) { create(:user, name: 'ユーザーC', email: 'c@example.com') }
  let!(:musicpost) { create(:musicpost, title: 'テストA', user_id: user_b.id) }
  let!(:taxonomy_composer) { create(:taxonomy, name: "作曲家", position: 1) }
  let!(:taxonomy_instrument) { create(:taxonomy, name: "演奏楽器", position: 2) }

  before do
    login_for_system(user_a)
  end

  it 'フォローされた時に通知される' do
    visit user_path(user_b)
    click_button 'フォローする'
    within 'header' do
      click_link user_a.name
    end
    click_link 'ログアウト'
    login_for_system(user_b)
    expect(page).to have_css '.faa-ring'
    within 'header' do
      find('.fa-bell').click
    end
    expect(page).to have_content('ユーザーAさんがあなたをフォローしました')
  end

  it '投稿がお気に入りされた時に通知される' do
    visit root_url
    within "#favorite_form_#{musicpost.id}" do
      find('.unfavorite').click
    end
    within 'header' do
      click_link user_a.name
    end
    click_link 'ログアウト'
    login_for_system(user_b)
    visit root_url
    within "#favorite_form_#{musicpost.id}" do
      find('.unfavorite').click
    end
    expect(page).to have_css '.faa-ring'
    within 'header' do
      find('.fa-bell').click
    end
    expect(page).to have_content('ユーザーAさんがあなたの投稿（テストA）をお気に入り登録しました')
    expect(page).not_to have_content('ユーザーBさんがあなたの投稿（テストA）をお気に入り登録しました')
  end

  it 'コメントに通知される' do
    visit musicpost_path(musicpost.id)
    fill_in 'content', with: 'ユーザーAのテストです'
    click_button 'コメント'
    within 'header' do
      click_link user_a.name
    end
    click_link 'ログアウト'

    login_for_system(user_c)
    visit musicpost_path(musicpost.id)
    fill_in 'content', with: 'ユーザーCのテストです'
    click_button 'コメント'
    within 'header' do
      click_link user_c.name
    end
    click_link 'ログアウト'

    login_for_system(user_b)
    visit musicpost_path(musicpost.id)
    fill_in 'content', with: 'ユーザーBのテストです'
    click_button 'コメント'
    expect(page).to have_css '.faa-ring'
    within 'header' do
      find('.fa-bell').click
    end
    within all('.notification')[0] do
      expect(page).to have_content('ユーザーCさんがテストAにコメントしました')
      expect(page).to have_content('ユーザーCのテストです')
    end
    within all('.notification')[1] do
      expect(page).to have_content('ユーザーAさんがテストAにコメントしました')
      expect(page).to have_content('ユーザーAのテストです')
    end
    expect(page).not_to have_content('ユーザーBのテストです')
    within 'header' do
      click_link user_b.name
    end
    click_link 'ログアウト'

    login_for_system(user_a)
    expect(page).to have_css '.faa-ring'
    within 'header' do
      find('.fa-bell').click
    end
    expect(page).to have_content('ユーザーCさんがテストAにコメントしました')
    expect(page).to have_content('ユーザーCのテストです')
  end
end
