require 'rails_helper'

RSpec.describe "Projects", type: :system do
  scenario "user creates a new project" do
    user = FactoryBot.create(:user)
    sign_in user

    visit root_path

    expect {
      click_link "New Project"
      fill_in_Name with: "Test Project"
      fill_in_Description "Trying out Capybara"
      click_button "Create Project"
    }.to change(user.projects, :count).by(1)  

    aggregate_failures do
      expect_have_content "Project was successfully created"
      expect_have_content "Test Project"
      expect_have_content "Owner: #{user.name}"
    end
  end

  def fill_in_Name(name)
    fill_in "Name", with: name
  end

  def fill_in_Description(name)
    fill_in "Description", with: name
  end

  def expect_have_content(name)
    expect(page).to have_content name
  end
end
