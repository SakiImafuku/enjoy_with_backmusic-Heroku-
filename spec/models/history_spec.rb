require 'rails_helper'

RSpec.describe History, type: :model do
  let!(:history) { create(:history) }

  it "historyが有効であること" do
    expect(history).to be_valid
  end

  it "user_idがnilの場合、無効であること" do
    history.user_id = nil
    expect(history).not_to be_valid
  end

  it "musicpost_idがnilの場合、無効であること" do
    history.musicpost_id = nil
    expect(history).not_to be_valid
  end
end
