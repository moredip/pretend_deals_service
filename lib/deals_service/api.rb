require 'grape'

require 'deals_service/deals_repo'

module DealsService
  class API < Grape::API
    format :json

    helpers do
      def deals_repo
        DealsRepo.new
      end
    end

    get '/deals' do
      deals_repo.deals
    end
  end
end
