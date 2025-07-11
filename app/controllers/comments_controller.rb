class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ destroy ]

  # POST /comments
  def create
    @comment = Comment.new(**comment_params, user_id: current_user.id)

    if @comment.save
      redirect_to activitable_path, notice: "Comment was successfully created."
    else
      render activitable_path, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    if @comment
      @comment.destroy!
      redirect_to activitable_path, notice: "Comment was successfully destroyed.", status: :see_other
    else
      render :not_found
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.where(user: current_user).find(params.expect(:id))
    end

    def activitable_path
      comment_params["activitable_type"].constantize.find(comment_params["activitable_id"])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.expect(comment: [
        :text, :activity_id, :activitable_id, :activitable_type, :user_id
      ])
    end
end
