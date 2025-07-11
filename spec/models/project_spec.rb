require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { Project.new(name: "Test Project") }
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:status) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(1) }
    it { should validate_length_of(:description).is_at_least(1) }
  end

  describe 'associations' do
    it { should have_many(:activities) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(to_do: 0, active: 1, done: 2, archived: 3) }
  end

  describe 'soft deletion' do
    let(:project) { create(:project) }

    it 'includes SoftDeletable concern' do
      expect(Project.included_modules).to include(SoftDeletable)
    end

    it 'soft deletes the project' do
      project.destroy
      expect(project.reload.deleted_at).to be_present
    end

    it 'excludes soft deleted projects from default scope' do
      project.destroy
      expect(Project.all).not_to include(project)
    end
  end
end
