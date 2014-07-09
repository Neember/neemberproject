class LeavesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @leaves = current_user.get_leaves_by_user.paginate(page: page)
  end

  def new
    @leave = Leave.new
  end

  def create
    @leave = Leave.new(leave_param)
    @leave.coder_id = current_user.id
    if @leave.save
      redirect_to leaves_path, notice: t('leave.message.create_leave_success')
    else
      flash[:alert] = t('leave.message.create_leave_failed')
      render :new
    end
  end

  protected
  def page
    params[:page]
  end

  def leave_param
    params.require(:leave).permit(:date, :hours, :reason, :coder_id)
  end
end
