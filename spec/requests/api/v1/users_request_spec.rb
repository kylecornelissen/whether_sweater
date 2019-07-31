require 'rails_helper'

describe "Users API" do
  it "user creates account" do
    post '/api/v1/users?email=test@test.com&password=swordfish&password_confirmation=swordfish'

    expect(response).to be_successful
    new_account = JSON.parse(response.body)["data"]["attributes"]

    expect(new_account).to have_key("email")
    expect(new_account["email"]).to eq("test@test.com")
    expect(new_account).to have_key("api_key")
    expect(new_account["api_key"]).to be_a String
  end

  it "user cannot create account with passwords that don't match" do
    post '/api/v1/users?email=test@test.com&password=swordfish&password_confirmation=swordfish222'

    expect(response).to be_successful
    new_account_fail = JSON.parse(response.body)

    expect(new_account_fail).to have_key("error")
    expect(new_account_fail["error"]).to eq("Password confirmation doesn't match Password")
  end

  it "user cannot create account with email that already exists" do
    user = User.create!(email: 'test@test.com', password: 'swordfish', password_confirmation: 'swordfish')

    post '/api/v1/users?email=test@test.com&password=swordfish&password_confirmation=swordfish'

    expect(response).to be_successful
    new_account_fail = JSON.parse(response.body)

    expect(new_account_fail).to have_key("error")
    expect(new_account_fail["error"]).to eq("Email has already been taken")
  end
end
