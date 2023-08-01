require 'rails_helper'
require 'webmock/rspec'

RSpec.describe StoreFacade do 
  it "exists and can create store objects" do 
    store_response = File.read('spec/fixtures/stores_response.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/stores/6%20Paimon%20St/48000")
      .to_return(status: 200, body: store_response, headers: { 'Content-Type': 'application/json' })
    
    store = StoreFacade.new("6 Paimon St", "30")
    expect(store).to be_a(StoreFacade)

  end
end