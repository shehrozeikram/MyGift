module Api
  module V1
    class AdsController < Api::V1::ApiController
      skip_before_action :authenticate_user!
      def ads
        begin
          ads =  Ad.all.map{|ad| ad.attachments.map{|att| {value: request.base_url + att.url}}}.flatten
          render json: { api_status: true, ads: ads }
        rescue
          render json: { api_status: false, error: "Something went wrong!" }
        end
      end
    end
  end
end
