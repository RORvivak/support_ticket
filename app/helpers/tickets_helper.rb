module TicketsHelper
  def all_department
  	return Department.all
  end
  def department(ticket)
  	return ticket.department.name
  end	
  def all_owner(ticket)
  	return User.where(:department_id=>ticket.department_id)
  end	
end
