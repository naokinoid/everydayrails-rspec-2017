require 'rails_helper'

RSpec.feature "Projects", type: :feature do
  scenario "user creates a new project" do
    user = FactoryBot.create(:user)

    visit root_path
    save_and_open_page
    click_link "Sign In"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect {
      click_link "New Project"
      fill_in "Name", with: "Test Project"
      fill_in "Description", with: "Trying out Capybara"
      click_button "Create Project"

      expect(page).to have_content "Project was successfully created."
      expect(page).to have_content "Test Project"
      expect(page).to have_content "Owner: #{user.name}"

    }.to change(user.projects, :count).by(1)

  end

  # scenario "guest adds a project" do
  #   visit projects_path
  #   # save_and_open_page
  #   click_link "New Project"
  # end


end
