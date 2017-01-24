class GradesController < OnGroupsController
  layout 'group'

  def index
    return render :admin_index if @group.admins.exists?(@user)
  end

  def create
    check_admin
    grades = grades_params.reject do |g|
      g[:name].blank? || g[:necessary_points].blank?
    end
    Grade.transaction do
      @group.grades.clear
      grades.each {|g| @group.grades.create!(g) }
    end
    redirect_to({action: :index}, alert: 'success')

    rescue
    redirect_to({action: :index}, alert: 'error')
  end

  private

  def grades_params
    params.require(:grades).map {|g| g.permit(:name, :necessary_points) }
  end
end
