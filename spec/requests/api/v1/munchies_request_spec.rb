require 'rails_helper'

describe "Yelp API" do
  before :each do
    allow(Time).to receive(:now).and_return(Time.at(1564423200))
  end

  it "gets start and end directions with food type and gives restaurants that are open" do
    VCR.use_cassette('services/yelp_service2') do
      get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=breakfast'


      expect(response).to be_successful
      munchies = JSON.parse(response.body)["data"]["attributes"]

      expect(munchies).to have_key("restaurants")
      expect(munchies["restaurants"].count).to eq(3)
      expect(munchies["restaurants"].first).to have_key("The Hanging Tree Cafe")
      expect(munchies["restaurants"].first["The Hanging Tree Cafe"]).to have_key("address1")
      expect(munchies["restaurants"].first["The Hanging Tree Cafe"]).to have_key("address2")
      expect(munchies["restaurants"].first["The Hanging Tree Cafe"]).to have_key("address3")
      expect(munchies["restaurants"].first["The Hanging Tree Cafe"]).to have_key("city")
      expect(munchies["restaurants"].first["The Hanging Tree Cafe"]).to have_key("zip_code")
      expect(munchies["restaurants"].first["The Hanging Tree Cafe"]).to have_key("country")
      expect(munchies["restaurants"].first["The Hanging Tree Cafe"]).to have_key("state")
    end
  end
end
