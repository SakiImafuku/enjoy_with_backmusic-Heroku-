require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com') }

  it "名前、メールアドレス、パスワードが入力されている場合成功する" do
    expect(user_a).to be_valid
  end

  it "名前が入力されていない場合失敗する" do
    user_a.name = nil
    user_a.valid?
    expect(user_a.errors[:name]).to include("が入力されていません。")
  end

  it "メールアドレスが入力されていない場合失敗する" do
    user_a.email = nil
    user_a.valid?
    expect(user_a.errors[:email]).to include("が入力されていません。")
  end

  it "名前が50文字を超える場合失敗する" do
    user_a.name = "a" * 51
    user_a.valid?
    expect(user_a.errors[:name]).to include("は50文字以下に設定して下さい。")
  end

  it "パスワードが５文字以下の場合失敗する" do
    user_a.password = "a" * 5
    user_a.valid?
    expect(user_a.errors[:password]).to include("は6文字以上に設定して下さい。")
  end

  it "自己紹介が300文字を超える場合失敗する" do
    user_a.self_introduction = "a" * 301
    user_a.valid?
    expect(user_a.errors[:self_introduction]).to include("は300文字以下に設定して下さい。")
  end

  it "メールアドレスがすでに使用されている場合失敗する" do
    user_b.email = user_a.email
    user_b.valid?
    expect(user_b.errors[:email]).to include("は既に使用されています。")
  end
end
