class SchedulesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @schedules = current_user.get_schedules_by_user.paginate(page: page)
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_param)
    @schedule.coder_id = current_user.id
    if @schedule.save
      redirect_to schedules_path, notice: t('schedule.message.create_schedule_success')
    else
      flash[:alert] = t('schedule.message.create_schedule_failed')
      render :new
    end
  end

  protected
  def page
    params[:page]
  end

  def schedule_param
    params.require(:schedule).permit(:date, :hours, :reason, :coder_id, :project_id)
  end
end
