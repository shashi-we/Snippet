require 'rails_helper'

describe Snippet do

  it { is_expected.to validate_presence_of(:description) }

  describe 'scope #without_private_snippet' do
    before do
      5.times { create(:snippet, is_private: true) }
      5.times { create(:snippet, is_private: false) }
    end
    it 'returns public snippets' do
      expect(Snippet.without_private_snippet.count).to eq 5
    end
  end

  describe '#search' do
    let(:snippet) { FactoryGirl.create(:snippet) }
    let(:query) { snippet.description }
    it 'returns search result' do
      expect(Snippet.search(query).count).to eq 1
    end
  end
end