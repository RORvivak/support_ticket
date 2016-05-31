class TicketPolicy < ApplicationPolicy
  attr_reader :user, :ticket
  
  def initialize(user, ticket)
    @user = user
    @ticket = ticket
  end

  def update?
    @user.id == @ticket.user_id
  end

  def create?
    user.Customer?
  end	
  
  def new?
    user.Customer?
  end

  def edit?
  	user.id == ticket.user_id
  end
  
  def show?
    user.id == ticket.user_id
  end

  def destroy?
  	user.id == ticket.user_id
  end
  
  def status_and_ownership?
    unless user.department_id.nil?   
      user.department_id == ticket.department_id
    else
      return false   
    end
  end

  def staff_chat?
    user.Staff? and user.id == ticket.staff_id
  end  
  
  def customer_chat?
    user.Customer? and user.id == ticket.user_id
  end 
  
  class Scope < Scope
  	 attr_reader :user, :scope

  	def initialize(user, scope)
      @user  = user
      @scope = scope
    end 
    
    def resolve
      if user.Admin?
        scope.all
      elsif user.Staff?
        scope.where(:department_id=>user.department_id)
      else
        scope.where(user_id: user.id)
      end
    end
  end
end
