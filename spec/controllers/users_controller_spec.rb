require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  before :each do
    User.destroy_all
  end

  it "creates/registers a new user" do
    create_user_params = {
      first: "Code", 
      last: "for Denver", 
      email: "codefordenver@gmail.com",
      password: "CFDFFC2015",
      password_confirmation: "CFDFFC2015", 
      role: :admin, 
      phone: "555.555.5555",
      confirm_success_url: "http://localhost:3000/"
    }
    post user_registration_path, create_user_params
    response_body = JSON.load(response.body)
    user = User.last

    expect(user.first).to eq create_user_params[:first]
    expect(user.last).to eq create_user_params[:last]
    expect(user.email).to eq create_user_params[:email]
    expect(BCrypt::Password.new(user.encrypted_password)).
      to eq create_user_params[:password]
    expect(user.role).to eq create_user_params[:role].to_s
    expect(user.phone).to eq create_user_params[:phone]
    expect(response_body["errors"]).to be_blank
    expect(response.status).to eq 200
  end

  it "updates a user"

  it "deletes a new user"

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

  it "allows an admin to request data for any user" do
    create_user_data

    # admin requests non-admin
    get api_v1_user_path(@user_cyclist.id), @user_admin_request_data
    response_body = JSON.load(response.body)

    expect(response_body["errors"]).to be_blank
    expect(response.status).to eq 200
    expect(response_body["user"]).to_not be_blank

    # admin requests self
    get api_v1_user_path(@user_admin.id), @user_admin_request_data
    response_body = JSON.load(response.body)

    expect(response_body["errors"]).to be_blank
    expect(response.status).to eq 200
    expect(response_body["user"]).to_not be_blank
  end

  it "does not allow a non-admin to retrieve data for a user other than self" do
    create_user_data

    # non-admin requests admin
    get api_v1_user_path(@user_admin.id), @user_cyclist_request_data
    response_body = JSON.load(response.body)

    expect(response_body["errors"]).to eq "access denied"
    expect(response.status).to eq 403
    expect(response_body["user"]).to be_blank

    # non-admin requests himself
    get api_v1_user_path(@user_cyclist.id), @user_cyclist_request_data
    response_body = JSON.load(response.body)

    expect(response_body["errors"]).to be_blank
    expect(response.status).to eq 200
    expect(response_body["user"]).to_not be_blank
  end

  it "allows an admin to retrieve data for a list of users" do
    create_user_data

    get api_v1_users_path, @user_admin_request_data
    response_body = JSON.load(response.body)

    expect(response_body["errors"]).to be_blank
    expect(response.status).to eq 200
    expect(response_body["users"].count).to eq User.count
    expect(response_body["users"].first["id"]).to eq User.first.id
    expect(response_body["users"].last["id"]).to eq User.last.id
  end

  it "does not allow a non-admin to retrieve data for a list of users" do
    create_user_data

    get api_v1_users_path, @user_cyclist_request_data
    response_body = JSON.load(response.body)

    expect(response_body["errors"]).to eq "access denied"
    expect(response.status).to eq 403
    expect(response_body["users"]).to be_blank
  end


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
      role: :cyclist, 
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
