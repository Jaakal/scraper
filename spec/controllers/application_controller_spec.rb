# frozen_string_literal: true

require_relative '../../application_controller.rb'

describe AsyncTest, type: :controller do
  describe 'GET index' do
    #         it "assigns @teams" do
    #         team = Team.create
    #         get :index
    #         expect(assigns(:teams)).to eq([team])
    #       end
    it 'renders the index template' do
      get '/'
      expect(response).to render_template(:index)
    end
  end
end
