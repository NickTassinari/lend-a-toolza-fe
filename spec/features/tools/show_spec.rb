# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tool Show Page' do
  it 'shows tool info' do
    saw_show = File.read('spec/fixtures/slam_saw_show.json')
    stub_request(:get, 'https://lend-a-toolza-be.onrender.com/api/v1/tools/1266')
      .to_return(status: 200, body: saw_show, headers: { 'Content-Type': 'application/json' })

    visit '/tools/1266'

    expect(page).to have_content('Slammer Saw')
  end
end
