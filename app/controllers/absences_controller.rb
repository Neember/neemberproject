class AbsencesController < ApplicationController
  before_filter :authenticate_user!

  def index
    if current_user.is_admin
      @absences = Absence.paginate(page: page)
    else
      @absences = current_user.becomes(Coder).absences.paginate(page: page)
    end
  end

  def new
    @absence = Absence.new
  end

  def create
    @absence = Absence.new(absence_param)
    @absence.coder = current_user.becomes(Coder)
    if @absence.save
      redirect_to absences_path, notice: t('absence.message.create_absence_success')
    else
      flash[:alert] = t('absence.message.create_absence_failed')
      render :new
    end
  end

  def destroy
    @absence = Absence.find(absence_id)
    if @absence.destroy
      redirect_to absences_path, notice: t('absence.message.delete_absence_success')
    else
      flash[:alert] = t('absence.message.create_absence_failed')
      render :index
    end
  end

  protected
  def page
    params[:page]
  end

  def absence_id
    params.require(:id)
  end

  def absence_param
    params.require(:absence).permit(:date, :hours, :reason, :project_id)
  end
end
