require 'rails_helper'

RSpec.describe User, type: :model do
  let(:password) { 'test123' }
  let(:user) { build(:user, password: password) }

  describe '#authenticate' do
    it "should authenticate password" do
      expect(user.authenticate password).to be_truthy
    end

    it "should not authenticate wrong password" do
      expect(user.authenticate 'a wrong password').to be_falsey
    end
  end
end
