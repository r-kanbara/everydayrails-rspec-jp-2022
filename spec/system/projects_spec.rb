require 'rails_helper'

RSpec.describe "Projects", type: :system do
  # ユーザーは新しいプロジェクトを作成する
  scenario "user creates a new project" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect {
      click_link "New Project"
      fill_in "Name", with: "Test Project"
      fill_in "Description", with: "Trying out Capybara"
      click_button "Create Project"

      expect(page).to have_content "Project was successfully created"
      expect(page).to have_content "Test Project"
      expect(page).to have_content "Owner: #{user.name}"
    }.to change(user.projects, :count).by(1)
  end

  # ゲストがプロジェクトを追加する
  # scenario "guest adds a project" do
  #   visit projects_path
  #   save_and_open_page  # コンテナ環境では save_page
  #   click_link "New Project"
  # end

  # ユーザーは作成済みのプロジェクトを編集する
  scenario "user edits a created project" do
    user = FactoryBot.create(:user)
    project = FactoryBot.create(:project, owner: user)

    visit root_path
    click_link "Sign in"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect {
      click_link project.name
      click_link "Edit"
      fill_in "Name", with: "test project (updated)"
      click_button "Update Project"

      within ".alert" do
        expect(page).to have_content "Project was successfully updated."
      end
      expect(page).to have_content "test project (updated)"
      expect(page).to have_content project.description
      expect(page).to have_content "Owner: #{user.name}"
      expect(page).to have_content full_date(project.due_on)
    }.to_not change(user.projects, :count)
  end
end
