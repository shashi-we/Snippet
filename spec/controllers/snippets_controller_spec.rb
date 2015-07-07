require 'rails_helper'

describe SnippetsController do

  describe '#GET index' do
    it 'assigns @snippets' do
      snippet =  FactoryGirl.create(:snippet)
      get :index
      expect(assigns(:snippets)).to eq [snippet]
    end
    it 'return @snippets if search present' do
      snippet =  FactoryGirl.create(:snippet)
      get :index, search: 'Test'
      expect(assigns(:snippets)).to eq [snippet]
    end
  end

  describe '#GET new ' do
    it 'assigns new @snippet' do
      get :new
      expect(assigns(:snippet)).to be_a_new(Snippet)
    end
  end

  describe '#POST create' do
    context "with valid attributes" do
      it "creates a new snippet" do
        expect{ post :create, snippet: attributes_for(:snippet) }.to change(Snippet,:count).by(1)
      end
      it "redirects to the new snippet" do
        post :create, snippet: attributes_for(:snippet)
        should redirect_to Snippet.last
      end
    end
    context "with invalid attributes" do
      it "does not save the new snippet" do
        expect{ post :create, snippet: attributes_for(:snippet, description: '') }.to_not change(Snippet,:count)
      end
      it "re-renders the new method" do
        post :create, snippet: attributes_for(:snippet, description: '')
        should render_template('new')
      end
    end
  end

  describe '#GET show ' do
    it 'assigns @snippet' do
      snippet =  FactoryGirl.create(:snippet)
      get :show, id: snippet.id
      expect(assigns(:snippet)).to eq snippet
    end
  end

end