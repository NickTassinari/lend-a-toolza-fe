# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tool Index Page' do
  it 'has a list of searched tools and their attributes' do
    visit root_path
    tools_search = File.read('spec/fixtures/saw_search.json')
    stub_request(:get, 'https://lend-a-toolza-be.onrender.com/api/v1/tools/search?name=saw&location=CA')
      .to_return(status: 200, body: tools_search, headers: { 'Content-Type': 'application/json' })

    fill_in :tool, with: 'saw'
    fill_in :location, with: 'CA'
    click_button('Search')
     
    expect(current_path).to eq('/tools')
    expect(page).to have_content('Slammer Saw')
    expect(page).to have_content('Description: This bad boy will cover all your framing needs. Crooked stud? Nail popping up? Wanna just whack something? This hammer is the perfect tool!')
    expect(page).to have_content('Status: available')

    tool_show = File.read('spec/fixtures/slam_saw_show.json')
    stub_request(:get, 'https://lend-a-toolza-be.onrender.com/api/v1/tools/1266')
      .to_return(status: 200, body: tool_show, headers: { 'Content-Type': 'application/json' })

    click_link 'Slammer Saw'

    expect(current_path).to eq('/tools/1266')
  end

  it 'has a stores search form if there are no tools in our db' do
    visit root_path

    nil_tools_search = File.read('spec/fixtures/nil_search.json')
    stub_request(:get, 'https://lend-a-toolza-be.onrender.com/api/v1/tools/search?name=saw&location=CA')
      .to_return(status: 204, body: nil_tools_search, headers: { 'Content-Type': 'application/json' })

    store_response = File.read('spec/fixtures/stores_response.json')
    stub_request(:get, 'https://lend-a-toolza-be.onrender.com/api/v1/stores/90210/8000')
      .to_return(status: 200, body: store_response, headers: { 'Content-Type': 'application/json' })

    fill_in :tool, with: 'saw'
    fill_in :location, with: 'CA'

    click_button('Search')

    expect(current_path).to eq('/tools')
    expect(page).to have_content("Sorry that's a rare tool! We don't have that tool but you can search for a local hardware store below!")

    fill_in :location, with: '90210'
    fill_in :radius, with: '5'
    click_on 'Submit'
    expect(current_path).to eq('/stores')
    expect(page).to have_content('Hanks Hardware Howdy')
    expect(page).to have_content('123 Hermes Way, Denver, CO, 80218')
    expect(page).to have_content('Rickys Used Shit')
    expect(page).to have_content('18 Paimon Dr, Denver, CO, 80218')
  end
end
