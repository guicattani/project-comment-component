require 'rails_helper'

RSpec.describe StatusUpdateCreator, type: :service do
  let(:user) { create(:user) }
  let(:project) { create(:project, name: "Test Project", status: "to_do") }
  let(:attrs) { project.attributes }

  describe '#create' do
    let(:changed) { { "status" => "active", "name" => "Updated Project" } }
    let(:creator) { StatusUpdateCreator.new(attrs, changed, project, user) }

    it 'creates status update activities for each change' do
      expect {
        creator.create
      }.to change(Activity, :count).by(2)
    end

    context 'with only status field' do
      let(:changed) { { "status" => "active" } }

      it 'creates status update for status change' do
        creator.create
        status_activity = Activity.first

        expect(status_activity).to be_present
        expect(status_activity.content["from"]).to eq("to_do")
        expect(status_activity.content["to"]).to eq("active")
        expect(status_activity.user).to eq(user)
        expect(status_activity.activitable).to eq(project)
      end
    end

    context 'with only name field' do
      let(:changed) { { "name" => "Updated Project" } }
      it 'creates status update for name change' do
        creator.create
        name_activity = Activity.first

        expect(name_activity).to be_present
        expect(name_activity.content["from"]).to eq("Test Project")
        expect(name_activity.content["to"]).to eq("Updated Project")
        expect(name_activity.user).to eq(user)
        expect(name_activity.activitable).to eq(project)
      end
    end


    context 'with empty changes' do
      let(:changed) { {} }

      it 'does not create any activities' do
        expect {
          creator.create
        }.not_to change(Activity, :count)
      end
    end

    context 'with non-string values' do
      let(:changed) { { "status" => 2 } } # enum value for 'done'

      it 'handles non-string values correctly' do
        creator.create
        activity = Activity.last

        expect(activity.content["to"]).to eq(2)
      end
    end
  end
end
