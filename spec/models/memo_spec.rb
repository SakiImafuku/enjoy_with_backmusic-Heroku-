require 'rails_helper'

RSpec.describe Memo, type: :model do
  let!(:memo) { create(:memo) }

  it "memoが有効であること" do
    expect(memo).to be_valid
  end

  it "user_idがnilの場合、無効であること" do
    memo.user_id = nil
    expect(memo).not_to be_valid
  end

  it "musicpost_idがnilの場合、無効であること" do
    memo.musicpost_id = nil
    expect(memo).not_to be_valid
  end

  it "memoがnilの場合、無効であること" do
    memo.memo = nil
    expect(memo).not_to be_valid
  end

  it "memoが1000文字を超える場合、無効であること" do
    memo.memo = "a" * 1001
    expect(memo).not_to be_valid
  end
end
