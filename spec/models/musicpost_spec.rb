require 'rails_helper'

RSpec.describe Musicpost, type: :model do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:musicpost) { create(:musicpost) }

  it "user_id, title, overviewを保存する" do
    expect(musicpost).to be_valid
  end

  it "titleが入力されていない場合失敗する" do
    musicpost.title = nil
    musicpost.valid?
    expect(musicpost.errors[:title]).to include("が入力されていません。")
  end

  it "urser_idが入力されていない場合失敗する" do
    musicpost.user_id = nil
    musicpost.valid?
    expect(musicpost.errors[:user_id]).to include("が入力されていません。")
  end

  it "titleが50文字を超える場合失敗する" do
    musicpost.title = "a" * 51
    musicpost.valid?
    expect(musicpost.errors[:title]).to include("は50文字以下に設定して下さい。")
  end

  it "overviewが300文字を超える場合失敗する" do
    musicpost.overview = "a" * 301
    musicpost.valid?
    expect(musicpost.errors[:overview]).to include("は300文字以下に設定して下さい。")
  end
end
