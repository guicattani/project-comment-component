require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: "Test User") }
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(1) }
  end

  describe 'associations' do
    it { should have_many(:activities).dependent(:delete_all) }
  end

  describe 'attributes' do
    it 'has a default color' do
      user = User.new(name: 'Test User')
      expect(user.color).to eq('sky')
    end
  end

  describe 'factory' do
    it 'creates a valid user' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'creates users with unique names' do
      user1 = create(:user)
      user2 = create(:user)
      expect(user1.name).not_to eq(user2.name)
    end
  end
end
