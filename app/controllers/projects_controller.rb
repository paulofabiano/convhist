class ProjectsController < ApplicationController
  before_action :require_login

  before_action :set_project, only: [:show, :update]

  def index
    @project = Project.new(
      user: current_user
    )

    @projects = Project.all
  end

  def show
    @comment = Comment.new(user: current_user)
    @comments = @project.comments
  end

  def update
    @project.update(project_params)

    changes = @project.previous_changes["status"]

    unless changes.uniq.one?
      # =======================
      # Make it a service later
      # =======================
      Comment.create(
        body: "Status changed from #{changes[0]} to #{changes[1]} by #{current_user.email}", 
        status_changed: true,
        previous_status: changes[0],
        new_status: changes[1],
        user: current_user,
        project: @project
      )
    end

    @comments = @project.comments
  end

  def create
    @project = Project.new(project_params)
    @project.user = current_user

    if @project.save
      flash[:notice] = "Project saved successfully."
    else
      render :new, status: :unprocessable_entity
      flash[:error] = "Unable to save new project."
    end

    @projects = Project.all
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:id, :name, :status, :user_id, :description)
  end
end
