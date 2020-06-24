require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:comment) { create(:comment) }

  it "commentが有効であること" do
    expect(comment).to be_valid
  end

  it "user_idがnilの場合、無効であること" do
    comment.user_id = nil
    expect(comment).not_to be_valid
  end

  it "musicpost_idがnilの場合、無効であること" do
    comment.musicpost_id = nil
    expect(comment).not_to be_valid
  end

  it "コメントがnilの場合、無効であること" do
    comment.content = nil
    expect(comment).not_to be_valid
  end

  it "コメントが300文字を超える場合、無効であること" do
    comment.content = "a" * 301
    expect(comment).not_to be_valid
  end
end
