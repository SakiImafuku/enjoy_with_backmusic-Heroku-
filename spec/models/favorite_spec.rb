require 'rails_helper'

RSpec.describe Favorite, type: :model do
  let!(:favorite) { create(:favorite) }

  it "favoriteが有効であること" do
    expect(favorite).to be_valid
  end

  it "user_idがnilの場合、無効であること" do
    favorite.user_id = nil
    expect(favorite).not_to be_valid
  end

  it "musicpost_idがnilの場合、無効であること" do
    favorite.musicpost_id = nil
    expect(favorite).not_to be_valid
  end
end
