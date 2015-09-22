require 'functional_spec_helper'

BASE_SERVICE_URI = "http://#{APP_NAME}.cfapps.io/"

describe DealsService do
  it "returns deals" do
    uri = URI.parse(BASE_SERVICE_URI + 'deals')
    response = Net::HTTP.get_response(uri)
    expect(response.body).to start_with '[{"sku":"sweater"'
  end
end
