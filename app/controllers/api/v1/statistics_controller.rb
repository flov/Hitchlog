module Api
  module V1
    class StatisticsController < Api::V1::BaseController
      def top_10_hitchhikers
        @users = User.top_10_hitchhikers
      end

      def average_age_of_hitchhikers
      end
    end
  end
end
