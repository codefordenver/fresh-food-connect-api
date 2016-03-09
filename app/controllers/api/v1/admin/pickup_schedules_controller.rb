module Api
  module V1
    module Admin
      class PickupSchedulesController < BaseController
        include ActionController::ImplicitRender

        respond_to :json
        before_action :ensure_admin_user

        def create
          pickup_schedule = PickupSchedule.create(pickup_schedule_params)
          respond_with :api, :v1, :admin, pickup_schedule
        end

        private

        def pickup_schedule_params
          params.require(:pickup_schedule).permit([
            :notification_text,
            :notification_time,
            :pickup_date_range_end,
            :pickup_date_range_start,
            :pickup_time_range_end,
            :pickup_time_range_start,
            :zip_code
          ])
        end
      end
    end
  end
end
