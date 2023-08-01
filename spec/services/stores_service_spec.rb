require 'rails_helper'
require 'webmock/rspec'

RSpec.describe StoresService do
  it "#get_stores" do 
    store_response = File.read('spec/fixtures/stores_response.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/stores/CO/30")
      .to_return(status: 200, body: store_response, headers: { 'Content-Type': 'application/json' })
  
    location = "CO"
    radius = "30"

    search = StoresService.get_stores(location, radius)
    expect(search).to be_a(Hash)
    expect(search[:data][0][:id]).to eq("72")
    expect(search[:data][0][:attributes][:name]).to eq("Hanks Hardware Howdy")
    expect(search[:data][0][:attributes][:formatted_address]).to eq("123 Hermes Way, Denver, CO, 80218")

  end


end