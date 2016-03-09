require 'rails_helper'

describe 'Managing Pickup Schedules', type: :request do
  describe 'creating a new Pickup Schedule' do
    it 'creates a new Pickup Schedule' do
      pickup_schedule_params = {
        pickup_schedule: {
          zip_code: '80246',
          notification_text: 'We will pick up your veggies!',
          pickup_time_range_start: '8am',
          pickup_time_range_end: '11am',
          pickup_date_range_start: Date.tomorrow,
          pickup_date_range_end: 2.weeks.from_now,
          notification_time: '3pm'
        }
      }

      expect {
        post api_v1_admin_pickup_schedules_path, pickup_schedule_params
      }.to change { PickupSchedule.count }.by(1)

      expect(response.status).to eq 201
      expect(response).to match_response_schema('pickup_schedule')
    end
  end
end
