class ProjectsController < ApplicationController
  def index
    @projects = Project.all.paginate(page: params[:page])
  end
end
