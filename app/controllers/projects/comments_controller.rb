class Projects::CommentsController < ApplicationController
  before_action :require_login

  before_action :set_project
  before_action :set_comment, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.project_id = params[:project_id]

    if @comment.save
      @comment = Comment.new
      @comments = @project.comments
      flash[:notice] = "Comment saved successfully."
    else
      @comments = @project.comments
      render :new, status: :unprocessable_entity
      flash[:error] = "Unable to save new comment."
    end
  end

  def destroy
    unless @comment.destroy
      flash[:error] = "Unable to delete comment."
    end
      
    flash[:notice] = "Comment successfully deleted."
    @comments = @project.comments
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:id, :body, :status_changed, :previous_status, :new_status, :user_id, :project_id)
  end
end
