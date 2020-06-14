require 'rails_helper'

RSpec.describe Taxonomy, type: :model do
  let!(:taxonomy_a) { create(:taxonomy, name: "taxonomy_a", position: 1) }
  let!(:taxonomy_b) { create(:taxonomy, name: "taxonomy_b", position: 2) }

  it "name, postionを保存する" do
    expect(taxonomy_a).to be_valid
  end

  it "nameが入力されていない場合失敗する" do
    taxonomy_a.name = nil
    taxonomy_a.valid?
    expect(taxonomy_a.errors[:name]).to include("が入力されていません。")
  end

  it "positionが入力されていない場合失敗する" do
    taxonomy_a.position = nil
    taxonomy_a.valid?
    expect(taxonomy_a.errors[:position]).to include("が入力されていません。")
  end

  it "nameが50文字を超える場合失敗する" do
    taxonomy_a.name = "a" * 51
    taxonomy_a.valid?
    expect(taxonomy_a.errors[:name]).to include("は50文字以下に設定して下さい。")
  end

  it "nameが重複している場合失敗する" do
    taxonomy_b.name = taxonomy_a.name
    taxonomy_b.valid?
    expect(taxonomy_b.errors[:name]).to include("は既に使用されています。")
  end

  it "positionが重複している場合失敗する" do
    taxonomy_b.position = taxonomy_a.position
    taxonomy_b.valid?
    expect(taxonomy_b.errors[:position]).to include("は既に使用されています。")
  end
end
