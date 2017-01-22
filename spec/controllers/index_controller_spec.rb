require 'rails_helper'

describe IndexController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #fetch_new_data" do
    it "returns http success" do
      get :fetch_new_data
      expect(response).to have_http_status(302)
    end

    it "sould return json data" do
      get :fetch_new_data
      expect(response).to redirect_to :action => :index
    end

  end
end