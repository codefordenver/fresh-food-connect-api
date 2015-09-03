require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  it "authenticates" do
    u = User.new
    u.email = 'testuser'
    put "/sign_in", {:email => u.email, :password => 'Test1234'}

    expect(response).to be_success 
  end
end
