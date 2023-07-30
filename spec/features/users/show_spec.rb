require "rails_helper"

RSpec.describe "users show page" do 
  it "has users info" do 
    user = User.create!(id: 2, name: "Jiminy Crickets", email: "jiminies@gmail.com", google_id: '123456789')


    visit "users/#{user.id}"

    expect(page).to have_content("Jiminy Crickets")
  end
end