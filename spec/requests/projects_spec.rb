require 'rails_helper'

RSpec.describe "/projects", type: :request do
  let(:valid_attributes) {
    {
      name: "Test Project",
      description: "A test project description",
      status: "to_do"
    }
  }

  let(:invalid_attributes) {
    {
      name: "",
      description: "",
      status: ""
    }
  }
  describe "GET /index" do
    let!(:project) { create(:project) }
    it "renders a successful response" do
      get projects_url
      expect(response).to be_successful
    end

    it "displays project by their name" do
      get projects_url
      expect(response.body).to include(project.name)
    end
  end

  describe "GET /show" do
    let!(:project) { create(:project) }
    it "renders a successful response" do
      project = create(:project)
      get project_url(project)
      expect(response).to be_successful
    end

    it "displays project details" do
      project = create(:project)
      get project_url(project)
      expect(response.body).to include(project.name)
      expect(response.body).to include(project.description)
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_project_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    let!(:project) { create(:project) }

    it "renders a successful response" do
      get edit_project_url(project)
      expect(response).to be_successful
    end

    it "displays the edit form with current values" do
      get edit_project_url(project)
      expect(response.body).to include(project.name)
      expect(response.body).to include(project.description)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Project" do
        expect {
          post projects_url, params: { project: valid_attributes }
        }.to change(Project, :count).by(1)
      end

      it "redirects to the created project" do
        post projects_url, params: { project: valid_attributes }
        expect(response).to redirect_to(project_url(Project.last))
      end

      it "sets the correct attributes" do
        post projects_url, params: { project: valid_attributes }
        project = Project.last
        expect(project.name).to eq("Test Project")
        expect(project.description).to eq("A test project description")
        expect(project.status).to eq("to_do")
      end
    end

    context "with invalid parameters" do
      it "does not create a new Project" do
        expect {
          post projects_url, params: { project: invalid_attributes }
        }.to change(Project, :count).by(0)
      end

      it "renders a response with 422 status" do
        post projects_url, params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "displays validation errors" do
        post projects_url, params: { project: invalid_attributes }
        expect(response.body).to include("error")
      end
    end

    context "with duplicate name" do
      it "does not create a project with duplicate name" do
        create(:project, name: "Test Project")
        expect {
          post projects_url, params: { project: valid_attributes }
        }.to change(Project, :count).by(0)
      end
    end
  end

  describe "PATCH /update" do
    let!(:project) { create(:project) }

    let(:new_attributes) {
      {
        name: "Updated Project",
        description: "Updated description",
        status: "active"
      }
    }

    context "with valid parameters" do
      it "updates the requested project" do
        patch project_url(project), params: { project: new_attributes }
        project.reload
        expect(project.name).to eq("Updated Project")
        expect(project.description).to eq("Updated description")
        expect(project.status).to eq("active")
      end

      it "redirects to the project" do
        patch project_url(project), params: { project: new_attributes }
        expect(response).to redirect_to(project_url(project))
      end
    end

    context "with invalid parameters" do
      it "renders a response with 422 status" do
        patch project_url(project), params: { project: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "does not update the project" do
        original_name = project.name
        patch project_url(project), params: { project: invalid_attributes }
        project.reload
        expect(project.name).to eq(original_name)
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:project) { create(:project) }

    it "destroys the requested project" do
      expect {
        delete project_url(project)
      }.to change(Project, :count).by(-1)
    end

    it "redirects to the projects list" do
      delete project_url(project)
      expect(response).to redirect_to(projects_url)
    end

    it "soft deletes the project" do
      delete project_url(project)
      expect(project.reload.deleted_at).to be_present
    end
  end
end
