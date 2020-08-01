require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:notification) { create(:notification) }

  it "notificationが有効であること" do
    expect(notification).to be_valid
  end

  it "musicpost_idがnilでもnotificationが有効であること" do
    notification.musicpost_id = nil
    expect(notification).to be_valid
  end

  it "comment_idがnilでもnotificationが有効であること" do
    notification.comment_id = nil
    expect(notification).to be_valid
  end

  it "visitorがnilの場合、無効であること" do
    notification.visitor_id = nil
    expect(notification).not_to be_valid
  end

  it "visited_idがnilの場合、無効であること" do
    notification.visited_id = nil
    expect(notification).not_to be_valid
  end

  it "actionがnilの場合、無効であること" do
    notification.action = nil
    expect(notification).not_to be_valid
  end
end
