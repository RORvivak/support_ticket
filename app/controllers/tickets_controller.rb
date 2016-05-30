class TicketsController < ApplicationController
	before_filter :find_ticket, :only=> [:show,:change_status_and_ownership,:status_and_ownership,:update, :destroy, :edit]
	
  def new
    # authorize Ticket
    @ticket  = current_user.tickets.build
    authorize @ticket
  end
    
  def create
    # authorize Ticket
    @ticket =  current_user.tickets.new(ticket_params)
    authorize @ticket
    if @ticket.save
      TicketNotifier.Ticket_verification_customer(current_user,@ticket).deliver_later 
      TicketNotifier.Ticket_verification_staff(@ticket).deliver_later 
      flash[:notice] = "Ticket has been created successfully"
      redirect_to tickets_path
    else
      flash[:notice] = "Ticket has not been created"
      render 'new' 
    end   
  end

  def show
    authorize @ticket
    @ticket_history = @ticket.ticket_staff_statuses
    @owners = @ticket_history.includes(:staff).pluck(:email)
    @assigned_by = @ticket_history.includes(:user).pluck(:email)
    @dates = @ticket_history.pluck(:created_at)
    @history_statuses = @ticket_history.pluck(:status)
    @status = []
     # enum :status=> [:Waiting_for_Staff_Response,:Waiting_for_Customer,:on_hold,:cancelled,:completed]
    @history_statuses.each do |h_s|
      @status<<Ticket.statuses.select{|k,v| v == h_s}.keys.flatten
    # redirect_to :bac
    # @status.compact!
    end
    @status.flatten! 
    @show = @owners.zip(@status,@dates,@assigned_by)

  end

  def search_form
  end


  # def search
  #   @ticket = Ticket.search(params[:token]).first
  #   unless @ticket.nil?
  #     @title = @ticket.title
  #     @body = @ticket.body
  #     @user = @ticket.user
  #   else
  #     flash[:notice] = "No result found"
  #     redirect_to user_dashboard_view_path
  #   end   
  # end  

  def edit
    authorize @ticket
  end
     
  def index
    if !params[:status].nil? 
      @tickets_with_status = Ticket.where(:status=>params[:status].to_i)
      @tickets =  policy_scope(@tickets_with_status)
    
    elsif !params[:token].nil?
      @tickets_with_token_or_subject = Ticket.where('token=? OR title=?',params[:token],params[:token])
      @tickets =  policy_scope(@tickets_with_token_or_subject)   
    else  
      @tickets =  policy_scope(Ticket)
    end
    @tickets = @tickets.paginate(:page => params[:page], :per_page => 10)
  end   
    
  def update
    authorize @ticket
    if @ticket.update(ticket_params)
      flash[:notice] = 'Ticket has updated successfully'
    else
      flash[:notice] = "Ticket hasn't been updated "
    end
    render 'edit'
  end

  def destroy
    authorize @ticket
    if @ticket.destroy
      flash[:notice] = "Ticket has been successfully destroyed" 
    else
      flash[:notice] = "sorry destroy action hasn't done" 
    end
     redirect_to tickets_path
  end	

  def find_ticket
    @ticket = Ticket.find(params[:id].to_i)
  end

  def status_and_ownership
    authorize @ticket
  end  
  
  def change_status_and_ownership
    @ticket.check_history = true
    @ticket.current_user_id = current_user.id
    if @ticket.update(ticket_params)
       # @t = @ticket.ticket_staff_statuses.new('staff_id'=>@ticket.staff_id,'status'=>@ticket.status)
       # @t.save
      flash[:notice] = "Ticket has been updated" 
    else
      flash[:notice] = "sorry can't able to proceed the action" 
    end
     redirect_to tickets_path
  end

  private
    
  def ticket_params
    params.require(:ticket).permit(:title,:body,:staff_id,:department_id,:status)
  end 
     
end