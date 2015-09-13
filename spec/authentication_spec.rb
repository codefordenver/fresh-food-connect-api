require 'rails_helper'

RSpec.describe "Authentication (Devise Token Auth)", type: :request do

  it "user logs in and receives a token" do
    user = User.create!(
      first: "Code", 
      last: "for Denver", 
      email: "codefordenver@gmail.com",
      password: "CFDFFC2015", 
      role: :admin, 
      phone: "555.555.5555",
      confirmed_at: Date.today
    )
    
    post user_session_path, {
      email: user.email, 
      password: user.password
    }
    response_body = JSON.load(response.body)
    expect(response_body["errors"]).to be_blank
    expect(response.header["access-token"]).not_to be_blank
    expect(response.status).to eq 200
  end

  it "user logs out" do
    user = User.create!(
      first: "Code", 
      last: "for Denver", 
      email: "codefordenver@gmail.com",
      password: "CFDFFC2015", 
      role: :admin, 
      phone: "555.555.5555",
      confirmed_at: Date.today
    )
    
    post user_session_path, {
      email: user.email, 
      password: user.password
    }

    expect(user.reload.tokens.count).to eq 1

    delete destroy_user_session_path, {
      "access-token": response.header["access-token"], 
      client: response.header["client"], 
      uid: response.header["uid"]
      # expiry: response.header["expiry"], 
      # "token-type": response.header["token-type"],
    }
    response_body = JSON.load(response.body)
    expect(response_body["errors"]).to be_blank
    expect(response.status).to eq 200
    expect(user.reload.tokens.count).to eq 0
  end

  it "validates a token" do
    user = User.create!(
      first: "Code", 
      last: "for Denver", 
      email: "codefordenver@gmail.com",
      password: "CFDFFC2015", 
      role: :admin, 
      phone: "555.555.5555",
      confirmed_at: Date.today
    )
    
    post user_session_path, {
      email: user.email, 
      password: user.password
    }

    get api_v1_auth_validate_token_path, {
      "access-token": response.header["access-token"], 
      client: response.header["client"], 
      uid: response.header["uid"],
      expiry: response.header["expiry"], 
      "token-type": response.header["token-type"]
    }

    response_body = JSON.load(response.body)
    expect(response_body["success"]).to be_truthy
    expect(response_body["data"]).to_not be_blank
    expect(response.status).to eq 200
    expect(response_body["data"]["uid"]).to eq user.uid
  end

  it "does not allow access without a valid token"

end