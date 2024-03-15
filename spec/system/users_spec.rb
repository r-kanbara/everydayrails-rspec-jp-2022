require 'rails_helper'

RSpec.describe "Users", type: :system do
  # 完了済みのプロジェクトを非表示にする
  scenario "completed projects don't appear in the user's dashboard", :focus do
    # 完了済みのプロジェクトと未完了のプロジェクトを準備する
    user = FactoryBot.create(:user)
    completed_project = FactoryBot.create(:project, :completed,
                                          name: "completed_project",
                                          owner: user)
    incompleted_project = FactoryBot.create(:project, :incompleted,
                                            name: "incompleted_project",
                                            owner: user)

    # ユーザーはログインしている
    login_as user, scope: :user

    # ユーザーがプロジェクト画面を開くと，
    visit root_path

    aggregate_failures do
      # 完了済みのプロジェクトは表示されない
      expect(completed_project.completed?).to be true
      expect(page).to_not have_selector "a", text: /^completed_project$/

      # 未完了のプロジェクトは表示される
      expect(incompleted_project.completed?).to be false
      expect(page).to have_selector "a", text: /^incompleted_project$/
    end
  end
end
