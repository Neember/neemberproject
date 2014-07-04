class ProjectsController < ApplicationController
  def index
    @projects = Project.all.paginate(page: page)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_param)
    if @project.save
      redirect_to projects_path, notice: t('project.message.create_project_success')
    else
      flash[:alert] = t('project.message.create_project_failed')
      render :new
    end
  end

  def edit
    @project = Project.find(project_id)
  end

  def update
    @project = Project.find(project_id)
    if @project.update(project_param)
      redirect_to projects_path, :notice => t('project.message.update_project_success')
    else
      flash[:alert] = t('project.message.update_project_failed')
      render :new
    end
  end

  def destroy
    @project = Project.find(project_id)
    if @project.destroy
      redirect_to projects_path, :notice => t('project.message.delete_project_success')
    else
      flash[:alert] = t('project.message.delete_project_failed')
      render :index
    end
  end

  protected
  def page
    params[:page]
  end

  def project_id
    params.require(:id)
  end

  def project_param
    params.require(:project).permit(:name, :domain, :date_started, :no_of_sprints, :price_per_sprint, :quotation_no, :client_id)
  end

end
