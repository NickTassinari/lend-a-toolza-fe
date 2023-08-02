require 'rails_helper'

RSpec.describe Store do 
  it "exists and has attributes" do 

    store_data = {
                  "id": "85",
                  "attributes": {
                    "name": "Rickys Used Shit",
                    "formatted_address": "123 onetwothree Street, Denver, Co, 80218"
                  }
                }

    store = Store.new(store_data)

    expect(store.name).to eq("Rickys Used Shit")
    expect(store.id).to eq("85")
    expect(store.formatted_address).to eq("123 onetwothree Street, Denver, Co, 80218")
  end
end