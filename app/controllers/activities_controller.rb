class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ edit update destroy ]

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      redirect_to @activity, notice: "Activity was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /activities/1
  def update
    if @activity.update(activity_params)
      redirect_to @activity, notice: "Activity was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /activities/1
  def destroy
    if @activity
      @activity.destroy!
      redirect_to projects_path, notice: "Activity was successfully destroyed.", status: :see_other
    else
      render :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.where(user: current_user).find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def activity_params
      params.expect(activity: [ :content, :activity_id, :activitable, :activitable_type, :user_id ])
    end
end
