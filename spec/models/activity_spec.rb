require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:activitable_type) }
    it { should validate_presence_of(:activitable_id) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'associations' do
    it { should belong_to(:activitable) }
    it { should belong_to(:user) }
  end

  describe 'soft deletion' do
    let(:activity) { create(:activity, :comment) }

    it 'soft deletes the activity' do
      activity.destroy
      expect(activity.reload.deleted_at).to be_present
    end

    it 'excludes soft deleted activities from default scope' do
      activity.destroy
      expect(Activity.all).not_to include(activity)
    end
  end

  describe 'STI subclasses' do
    describe 'Comment' do
      let(:comment) { create(:activity, :comment) }

      it 'has the correct type' do
        expect(comment.type).to eq('Comment')
      end

      it 'implements serialize method' do
        expect(comment.serialize).to eq('This is a test comment')
      end

      it 'implements action method' do
        expect(comment.action).to eq('commented')
      end
    end

    describe 'StatusUpdate' do
      let(:status_update) { create(:activity, :status_update) }

      it 'has the correct type' do
        expect(status_update.type).to eq('StatusUpdate')
      end

      it 'implements serialize method' do
        expect(status_update.serialize).to include('Changed from <b>To do</b> to <b>Active</b>')
      end

      it 'implements action method' do
        expect(status_update.action).to eq('updated the status')
      end
    end
  end
end
