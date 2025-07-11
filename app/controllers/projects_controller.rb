require_relative "../services/activity_creator"
class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  before_action :cache_changes, only: %i[ update ]

  CREATE_ACTIVITY_ON_CHANGE = %w[name status]

  # GET /projects
  def index
    @projects = Project.all
  end

  # GET /projects/1
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = Project.new(project_params)

    if @project.save
      redirect_to @project, notice: "Project was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      create_change_activity
      redirect_to @project, notice: "Project was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy!
    redirect_to projects_path, notice: "Project was successfully destroyed.", status: :see_other
  end

  private

    def create_change_activity
      filtered_params = @changed.select { |k, v| CREATE_ACTIVITY_ON_CHANGE.include?(k) }
      return if filtered_params.empty?

      ::StatusUpdateCreator.create(@project_attrs,
                                   filtered_params,
                                   @project,
                                   current_user)
    end

    def cache_changes
      @project_attrs = @project.attributes
      ## Hash diff
      @changed = project_params
                .reject { |k, v| %w[id created_at updated_at].include?(k) }
                .reject { |k, v| @project_attrs [k] == v }
                .merge(@project_attrs .reject { |k, v| project_params.has_key?(k) }).to_h
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.includes(:activities).find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.expect(project: [ :name, :description, :status ])
    end
end
