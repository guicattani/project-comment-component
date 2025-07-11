require 'rails_helper'

RSpec.describe "/comments", type: :request do
  let(:user) { create(:user) }
  let(:project) { create(:project) }

  let(:valid_attributes) {
    {
      text: "This is a test comment",
      activitable_type: "Project",
      activitable_id: project.id
    }
  }

  let(:invalid_attributes) {
    {
      text: "",
      activitable_type: "Project",
      activitable_id: project.id
    }
  }

  let(:new_attributes) {
    {
      text: "Updated comment text"
    }
  }

  before do
    # Mock current_user to return our test user
    allow_any_instance_of(ApplicationHelper).to receive(:current_user).and_return(user)
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Comment" do
        expect {
          post comments_url, params: { comment: valid_attributes }
        }.to change(Activity, :count).by(1)
      end

      it "creates a comment with correct attributes" do
        post comments_url, params: { comment: valid_attributes }
        comment = Activity.last
        expect(comment.type).to eq("Comment")
        expect(comment.content["text"]).to eq("This is a test comment")
        expect(comment.user).to eq(user)
        expect(comment.activitable).to eq(project)
      end

      it "redirects to the activitable" do
        post comments_url, params: { comment: valid_attributes }
        expect(response).to redirect_to(project_url(project))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Comment" do
        expect {
          post comments_url, params: { comment: invalid_attributes }
        }.to change(Activity, :count).by(0)
      end

      it "renders a response with 422 status" do
        post comments_url, params: { comment: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:comment) { create(:activity, :comment, user: user, activitable: project) }

    context "when comment exists" do
      it "destroys the requested comment" do
        expect {
          delete comment_url(comment)
        }.to change(Activity, :count).by(-1)
      end

      it "soft deletes the comment" do
        delete comment_url(comment)
        expect(comment.reload.deleted_at).to be_present
      end
    end

    context "when comment does not exist" do
      it "renders not found" do
        delete comment_url("1")
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user is not the comment owner" do
      let(:other_user) { create(:user) }
      let!(:other_comment) { create(:activity, :comment, user: other_user, activitable: project) }

      it "raises RecordNotFound" do
        delete comment_url(other_comment)
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
