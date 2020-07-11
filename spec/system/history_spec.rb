require 'rails_helper'

describe 'Musicpost', type: :system, js: true do
  let!(:user) { create(:user) }
  let!(:musicpost_a) { create(:musicpost, title: 'テストA') }
  let!(:musicpost_b) { create(:musicpost, title: 'テストB') }
  let!(:musicpost_c) { create(:musicpost, title: 'テストC') }

  before do
    login_for_system(user)
  end

  it '視聴履歴ページに移動する' do
    visit root_url
    find("#play_pause_button_#{musicpost_a.id}").click
    find("#play_pause_button_#{musicpost_b.id}").click

    click_link 'Library'
    click_link '視聴履歴'
    within all('.musicpost')[0] do
      expect(page).to have_content musicpost_b.title
    end
    within all('.musicpost')[1] do
      expect(page).to have_content musicpost_a.title
    end
    expect(page).not_to have_content musicpost_c.title
  end
end
