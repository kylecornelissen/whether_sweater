require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  it '#set_api_key' do
    user = User.create!(email: "email@email.com", password: "pass", password_confirmation: "pass")
    key = user[:api_key]
    expect(key).to be_a String
  end
end
