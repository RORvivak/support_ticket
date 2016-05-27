module AdminUserRegistrationsHelper
  def all_department
  	@department = Department.all
  	return @department
  end 
end
