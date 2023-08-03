require 'rails_helper'
require 'webmock/rspec'

RSpec.describe ChatApiService do 
  it 'returns openAI chat response from given project prompt', :vcr do 
    # chat_prompt = File.read('spec/fixtures/chat_response.json')
    # stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/chat_request?project=deck")
    #   .to_return(status: 200, body: chat_prompt, headers: {'Content-Type': 'application/json' })

    project = "deck"

    chat = ChatApiService.chat_request(project)
    expect(chat).to be_an(Array)
  end
end