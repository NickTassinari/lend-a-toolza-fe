require 'rails_helper'
require 'webmock/rspec'

RSpec.describe StoreFacade do 
  it "exists and can create store objects" do 
    store_response = File.read('spec/fixtures/stores_response.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/stores/6%20Paimon%20St/48000")
      .to_return(status: 200, body: store_response, headers: { 'Content-Type': 'application/json' })
    
    store = StoreFacade.get_stores("6 Paimon St", "30")
    expect(store).to be_an(Array)
    expect(store[0]).to be_a(Store)
    expect(store.first.name).to eq("Hanks Hardware Howdy")
    expect(store.first.formatted_address).to eq("123 Hermes Way, Denver, CO, 80218")
    expect(store.first.id).to eq("72")
  end
end