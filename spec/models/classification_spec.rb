require 'rails_helper'

RSpec.describe Classification, type: :model do
  let!(:musicpost) { create(:musicpost) }
  let!(:taxonomy) { create(:taxonomy) }
  let!(:taxon_a) { create(:taxon, name: "taxon_a", taxonomy: taxonomy) }
  let!(:taxon_b) { create(:taxon, name: "taxon_b", taxonomy: taxonomy) }
  let!(:classification_a) { create(:classification, musicpost: musicpost, taxon: taxon_a) }
  let!(:classification_b) { create(:classification, musicpost: musicpost, taxon: taxon_b) }

  it "musicpost_id, taxon_idが保存される" do
    expect(classification_a).to be_valid
  end

  it "musicpost_idが入力されていない場合失敗する" do
    classification_a.musicpost_id = nil
    classification_a.valid?
    expect(classification_a.errors[:musicpost_id]).to include("が入力されていません。")
  end

  it "taxon_idが入力されていない場合失敗する" do
    classification_a.taxon_id = nil
    classification_a.valid?
    expect(classification_a.errors[:taxon_id]).to include("が入力されていません。")
  end

  it "musicpost_idとtaxon_idの組み合わせが重複する場合失敗する" do
    classification_b.musicpost_id = classification_a.musicpost_id
    classification_b.taxon_id = classification_a.taxon_id
    classification_b.valid?
    expect(classification_b.errors[:musicpost_id]).to include("は既に使用されています。")
  end
end
