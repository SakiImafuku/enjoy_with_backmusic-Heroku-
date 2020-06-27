require 'rails_helper'

describe 'Search', type: :system, js: true do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:taxonomy_composer) { create(:taxonomy, name: "作曲家", position: 1) }
  let!(:taxonomy_instrument) { create(:taxonomy, name: "演奏楽器", position: 2) }
  let!(:taxon_a) { create(:taxon, name: "作曲家A", taxonomy_id: taxonomy_composer.id) }
  let!(:taxon_b) { create(:taxon, name: "作曲家B", taxonomy_id: taxonomy_composer.id) }
  let!(:musicpost_a) { create(:musicpost, title: 'テストA', user_id: user_a.id, overview: "概要A") }
  let!(:musicpost_b) { create(:musicpost, title: 'テストB', user_id: user_b.id, overview: "概要B") }
  let!(:class_a) { create(:classification, musicpost_id: musicpost_a.id, taxon_id: taxon_a.id) }
  let!(:class_b) { create(:classification, musicpost_id: musicpost_b.id, taxon_id: taxon_b.id) }
  let!(:comment) { create(:comment, musicpost_id: musicpost_a.id, content: "テストコメントです") }
  let!(:memo) { create(:memo, musicpost_id: musicpost_a.id, memo: "テストメモです") }

  before do
    login_for_system(user_a)
  end

  it 'タイトルで検索する' do
    visit root_url
    fill_in 'search', with: "テストA\n"
    expect(page).to have_content musicpost_a.title
    expect(page).not_to have_content musicpost_b.title
    # 該当がない場合は何も表示しない
    fill_in 'search', with: "テストC\n"
    expect(page).not_to have_content musicpost_a.title
    expect(page).not_to have_content musicpost_b.title
  end

  it '概要で検索する' do
    visit root_url
    fill_in 'search', with: "概要A\n"
    expect(page).to have_content musicpost_a.title
    expect(page).not_to have_content musicpost_b.title
  end

  it 'ユーザー名で検索する' do
    visit root_url
    fill_in 'search', with: "ユーザーA\n"
    expect(page).to have_content musicpost_a.title
    expect(page).not_to have_content musicpost_b.title
  end

  it 'Taxonで検索する' do
    visit root_url
    fill_in 'search', with: "作曲家A\n"
    expect(page).to have_content musicpost_a.title
    expect(page).not_to have_content musicpost_b.title
  end

  it 'コメントで検索する' do
    visit root_url
    fill_in 'search', with: "テストコメント\n"
    expect(page).to have_content musicpost_a.title
    expect(page).not_to have_content musicpost_b.title
  end

  it 'メモで検索する' do
    visit root_url
    fill_in 'search', with: "テストメモ\n"
    expect(page).to have_content musicpost_a.title
    expect(page).not_to have_content musicpost_b.title
  end
end
