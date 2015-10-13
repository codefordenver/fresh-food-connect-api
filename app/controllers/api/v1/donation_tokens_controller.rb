class Api::V1::DonationTokenssController < Api::V1::BaseController

  # get info about a specific token, like if it's been used or not
  def show
    dt = DonationToken.find_by(token: params[:token])
    render json: dt, status: :ok
  end
end