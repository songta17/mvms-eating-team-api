require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'is valid ' do
    it 'with a email and a password' do
      user = FactoryBot.create(:user)
      expect(user).to be_valid
    end
  end

  describe 'is invalid' do
    it 'without a email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).to_not be_valid
    end
    it 'without a password' do
      user = FactoryBot.build(:user, password: nil)
      expect(user).to_not be_valid
    end
  end
  
end
