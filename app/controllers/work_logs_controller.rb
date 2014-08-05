class WorkLogsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @work_logs = current_user.is_admin? ? WorkLog : current_coder.work_logs
    @work_logs = @work_logs.paginate(page: page)
  end

  def new
    @work_log = WorkLog.new
  end

  def create
    @work_log = WorkLog.new(work_log_param.merge(coder: current_coder))
    if @work_log.save
      redirect_to work_logs_path, notice: t('work_log.message.create_work_log_success')
    else
      flash[:alert] = t('work_log.message.create_work_log_failed')
      render :new
    end
  end

  def edit
    @work_log = WorkLog.find(work_log_id)
  end

  def update
    @work_log = WorkLog.find(work_log_id)
    if @work_log.update(work_log_param)
      redirect_to work_logs_path, notice: t('work_log.message.update_work_log_success')
    else
      flash[:alert] = t('work_log.message.update_work_log_failed')
      render :edit
    end
  end

  def destroy
    work_log = WorkLog.find(work_log_id)
    if work_log.destroy
      redirect_to work_logs_path, notice: t('work_log.message.delete_work_log_success')
    else
      flash[:alert] = t('work_log.message.create_work_log_failed')
      render :index
    end
  end

  protected
  def page
    params[:page]
  end

  def work_log_id
    params.require(:id)
  end

  def work_log_param
    params.require(:work_log).permit(:date, :hours, :reason, :status, :project_id)
  end

  def current_coder
    current_user.becomes(Coder)
  end
end
