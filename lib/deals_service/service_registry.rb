require 'deals_service/deals_repo'
require 'deals_service/deal_decorator'
require 'deals_service/pricing_gateway'

module DealsService
  class ServiceRegistry
    def self.for_env
      new(ENV)
    end

    def initialize(env)
      @env = env
    end

    def deals_repo
      @_deals_repo ||= DealsRepo.new
    end

    def deal_decorator
      @_deal_decorator ||= DealDecorator.new(pricing_gateway)
    end

    def pricing_gateway
      PricingGateway.new( ENV.fetch('PRICING_SERVICE_BASE_URL') )
    end
  end

  module ServiceRegistryMixin
    def deals_repo
      service_registry.deals_repo
    end

    def deal_decorator
      service_registry.deal_decorator
    end

    def service_registry
      global_setting(:service_registry) || global_setting(:service_registry,ServiceRegistry.for_env)
    end
  end
end
