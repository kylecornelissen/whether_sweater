require 'rails_helper'

describe "Sessions API" do
  before :each do
    @user = User.create!(email: 'test@test.com', password: 'swordfish', password_confirmation: 'swordfish')
  end

  it "logs user in" do
    post '/api/v1/sessions?email=test@test.com&password=swordfish'

    expect(response).to be_successful
    login = JSON.parse(response.body)["data"]["attributes"]

    expect(login).to have_key("email")
    expect(login["email"]).to eq("test@test.com")
    expect(login).to have_key("api_key")
    expect(login["api_key"]).to be_a String
  end

  it "does not log user in due to wrong email or password" do
    post '/api/v1/sessions?email=test@test.com&password=swordfish222'

    expect(response).to be_successful
    login_fail = JSON.parse(response.body)

    expect(login_fail).to have_key("error")
    expect(login_fail["error"]).to eq("Your email or password is invalid")
  end

  it "logs user out" do
    get '/api/v1/sessions?email=test@test.com&password=swordfish'

    expect(response).to be_successful

    get '/api/v1/logout'

    expect(response).to be_successful
    logout = JSON.parse(response.body)

    expect(logout).to have_key("message")
    expect(logout["message"]).to eq("User has logged out")
  end
end
