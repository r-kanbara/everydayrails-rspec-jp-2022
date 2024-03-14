require "rails_helper"

RSpec.describe Devise::Mailer, type: :mailer do
  describe "reset password instructions" do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { Devise::Mailer.reset_password_instructions(user, "token") }

    it "sends a password reset instructions to the user's mail address" do
      expect(mail.to).to eq [user.email]
      expect(mail.subject).to eq "Reset password instructions"
      expect(mail.body).to include "Hello #{user.email}!"
      expect(mail.body).to include "Someone has requested a link to change your password. You can do this through the link below."
    end
  end
end
