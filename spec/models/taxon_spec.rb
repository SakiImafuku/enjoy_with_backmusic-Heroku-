require 'rails_helper'

RSpec.describe Taxon, type: :model do
  let!(:taxonomy) { create(:taxonomy) }
  let!(:taxon_a) { create(:taxon, name: "taxon_a", taxonomy: taxonomy) }
  let!(:taxon_b) { create(:taxon, name: "taxon_b", taxonomy: taxonomy) }

  it "nameが保存される" do
    expect(taxon_a).to be_valid
  end

  it "nameが入力されていない場合失敗する" do
    taxon_a.name = nil
    taxon_a.valid?
    expect(taxon_a.errors[:name]).to include("が入力されていません。")
  end

  it "nameが50文字を超える場合失敗する" do
    taxon_a.name = "a" * 51
    taxon_a.valid?
    expect(taxon_a.errors[:name]).to include("は50文字以下に設定して下さい。")
  end

  it "nameが重複する場合失敗する" do
    taxon_b.name = taxon_a.name
    taxon_b.valid?
    expect(taxon_b.errors[:name]).to include("は既に使用されています。")
  end
end
