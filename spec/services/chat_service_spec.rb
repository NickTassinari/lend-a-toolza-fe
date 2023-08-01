require 'rails_helper'
require 'webmock/rspec'

RSpec.describe ChatService do 
  it 'returns openAI chat response from given project prompt' do 
    chat_prompt = File.read('spec/fixtures/chat_response.json')
    stub_request(:get, "https://lend-a-toolza-be.onrender.com/api/v1/chat_request")
      .to_return(status: 200, body: chat_prompt, headers: {'Content-Type': 'application/json' })

    project = "deck"

    chat = ChatService.chat_request(project)
    expect(chat).to be_a(Hash)
    expect(chat[:choices][0][:text]).to eq("You will need a drill, a circular saw, a hammer, a level, a tape measure, a post hole digger, a framing square, a screwdriver, deck screws, and lag screws. You may also need decking boards, joist hangers, and other hardware specific to your project.")
  end
end