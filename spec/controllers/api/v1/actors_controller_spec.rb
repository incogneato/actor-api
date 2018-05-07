require 'rails_helper'

RSpec.describe Api::V1::ActorsController, type: :controller do

  describe 'GET #index' do
    it 'returns a 200' do
      get :index, format: :json
      expect(response.status).to eq(200)
    end
  end

  describe 'GET #search' do
    before do
      actor = FactoryBot.create(:actor) do |actor|
        actor.create_most_known_work
      end
    end

    it "returns a 200" do
      get :search, params: { birth_month: '02', birth_day: '02' }, format: :json
      expect(response.status).to eq(200)
    end

    context "without proper dates" do
      it "throws an error" do
        get :search, params: { birth_month: 00, birth_day: 00 }, format: :json
        expect(response.status).to eq(422)
      end
    end
  end
end
