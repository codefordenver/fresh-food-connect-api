require 'rails_helper'

RSpec.describe "authentication", type: :request do
  before :all do
    @user = User.create(
      first: "Code", 
      last: "for Denver", 
      email: "codefordenver@gmail.com", 
      password: "CFDFFC2015", 
      role: :admin, 
      phone: "555.555.5555"
    )
  end

  it "authenticates" do
    post user_session_path, {email: @user.email, password: @user.password}
    
    response_body = JSON.load(response.body)
    expect(response_body["errors"]).to be_blank
    expect(response.status).to eq 200
  end
end