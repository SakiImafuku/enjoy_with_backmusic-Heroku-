require 'rails_helper'

describe 'Favorite', type: :system, js: true do
  let!(:user) { create(:user) }
  let!(:musicpost) { create(:musicpost, title: 'Title1') }
  let!(:musicpost2) { create(:musicpost, title: 'Title2') }

  before do
    login_for_system(user)
  end

  it 'お気に入り登録する' do
    visit root_url
    within "#favorite_form_#{musicpost.id}" do
      find('.unfavorite').click
    end
    click_link 'Library'
    within 'main' do
      expect(page).to have_content musicpost.title
      expect(page).not_to have_content musicpost2.title
    end
    within 'header' do
      click_link user.name
    end
    click_link 'プロフィール'
    click_link 'お気に入り'
    expect(page).to have_content musicpost.title
    expect(page).not_to have_content musicpost2.title
  end

  it 'お気に入り解除する' do
    visit root_url
    within "#favorite_form_#{musicpost.id}" do
      find('.unfavorite').click
    end
    within "#favorite_form_#{musicpost.id}" do
      find('.favorite').click
    end
    visit favorites_library_path(musicpost)
    within 'main' do
      expect(page).not_to have_content musicpost.title
      expect(page).not_to have_content musicpost2.title
    end
    within 'header' do
      click_link user.name
    end
    click_link 'プロフィール'
    click_link 'お気に入り'
    expect(page).not_to have_content musicpost.title
    expect(page).not_to have_content musicpost2.title
  end
end
