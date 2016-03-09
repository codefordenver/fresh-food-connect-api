require 'rails_helper'

module Api
  module V1
    module Admin
      describe PickupSchedulesController do
        describe '#create' do
          def valid_pickup_schedule_attrs
            {
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
          end

          it 'creates a new Pickup Schedule' do
            admin = create(:user, :admin)
            set_auth_headers_for(admin)

            expect {
              post :create, valid_pickup_schedule_attrs.merge(format: :json)
            }.to change { PickupSchedule.count }.by(1)

            expect(response).to have_http_status(:created)
            expect(response).to match_response_schema('pickup_schedule')
          end

          it 'does not allow access when given an auth token for a non-admin' do
            user = create(:user)
            set_auth_headers_for(user)

            expect {
              post :create, valid_pickup_schedule_attrs.merge(format: :json)
            }.not_to change { PickupSchedule.count }

            expect(response).to have_http_status(:unauthorized)
          end
        end
      end
    end
  end
end
