require 'rails_helper'

RSpec.describe HotelsPresenter do
  subject { described_class.new(params).call }

  before do
    create(:hotel, hotel_id: 'abc', destination_id: 123, name: "TUV")
    create(:hotel, hotel_id: 'def', destination_id: 456, name: "VWX")
    create(:hotel, hotel_id: 'ghi', destination_id: 789, name: "XYZ")
  end

  describe 'no parameters' do
    let(:params) { {} }

    it { expect(subject.count).to eq(3) }
    it { expect(subject.map(&:id)).to(match_array(["abc", "def", "ghi"]))}
  end

  context "params with page and per" do
    describe "page is 1, per is 2" do
      let(:params) { { page: 1, per: 2 } }

      it { expect(subject.map(&:id)).to(match_array(["abc", "def"]))}
    end

    describe "page is 2, per is 1" do
      let(:params) { { page: 2, per: 1 } }

      it { expect(subject.map(&:id)).to(match_array(["def"]))}
    end
  end

  context "params with search" do
    describe "search is V" do
      let(:params) { { search: "V" } }

      it { expect(subject.map(&:id)).to(match_array(["abc", "def"]))}
    end

    describe "search is UV" do
      let(:params) { { search: "UV" } }

      it { expect(subject.map(&:id)).to(match_array(["abc"]))}
    end
  end

  context "params with hotels" do
    describe "hotels is [abc]" do
      let(:params) { { hotels: ["ghi"] } }

      it { expect(subject.map(&:id)).to(match_array(["ghi"]))}
    end

    describe "hotels is []" do
      let(:params) { { hotels: [] } }

      it { expect(subject.map(&:id)).to(match_array(["abc", "def", "ghi"]))}
    end
  end

  context "params with destination" do
    describe "destination is empty" do
      let(:params) { { destination: '' } }

      it { expect(subject.map(&:id)).to(match_array(["abc", "def", "ghi"]))}
    end

    describe "destination is 456" do
      let(:params) { { destination: 456 } }

      it { expect(subject.map(&:id)).to(match_array(["def"]))}
    end
  end

  context "params with combination of hotels and destination" do
    describe "combination exists" do
      let(:params) { { hotels: ["def"], destination: 456 } }

      it { expect(subject.map(&:id)).to(match_array(["def"]))}
    end

    describe "combination does not exists" do
      let(:params) { { hotels: ["abc"], destination: 456 } }

      it { expect(subject).to(be_empty)}
    end
  end
end
