require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  before :each do
    User.destroy_all
  end

  it "retrieves data for a single user" do
    create_user_data
    get api_v1_user_path(@user_admin.id), @user_admin_request_data

    response_body = JSON.load(response.body)
    expect(response_body["errors"]).to be_blank
    expect(response.status).to eq 200
    expect(response_body["user"]["first"]).to eq @user_admin.first
    expect(response_body["user"]["last"]).to eq @user_admin.last
    expect(response_body["user"]["email"]).to eq @user_admin.email
    expect(response_body["user"]["role"]).to eq @user_admin.role
    expect(response_body["user"]["phone"]).to eq @user_admin.phone
    expect(response_body["user"]["uid"]).to eq @user_admin.uid
  end

  it "retrieves data for a list of users"


  private

  def create_user_data
    @user_admin = User.create!(
      first: "Code", 
      last: "for Denver", 
      email: "codefordenver@gmail.com",
      password: "CFDFFC2015", 
      role: :admin, 
      phone: "555.555.5555",
      confirmed_at: Date.today
    )
    
    post user_session_path, {
      email: @user_admin.email, 
      password: @user_admin.password
    }

    @user_admin_request_data = {
      "access-token": response.header["access-token"], 
      "client": response.header["client"], 
      "uid": response.header["uid"],
      "expiry": response.header["expiry"], 
      "token-type": response.header["token-type"]
    }

    @user_cyclist = User.create!(
      first: "FFC", 
      last: "Cyclist", 
      email: "cyclist@nowhere.org",
      password: "CFDFFC2015", 
      role: :admin, 
      phone: "555.555.5555",
      confirmed_at: Date.today
    )
    
    post user_session_path, {
      email: @user_cyclist.email, 
      password: @user_cyclist.password
    }

    @user_cyclist_request_data = {
      "access-token": response.header["access-token"], 
      "client": response.header["client"], 
      "uid": response.header["uid"],
      "expiry": response.header["expiry"], 
      "token-type": response.header["token-type"]
    }
  end
end
