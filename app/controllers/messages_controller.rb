class MessagesController < ApplicationController
	   respond_to :html, :js
    before_filter :authenticate_user!
     skip_before_filter :verify_authenticity_token 
      layout :false
  
  def create
   
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @message.save!
    @path = '/conversations/' + ( @conversation.id).to_s 
    p 'sddddddddddddddddddddddddddddddddddddd'
    p @path
    p 'sddddddddddddddddddddddddddddddddddddd'
     # respond_to do |format|
     #    format.js
     #  end  

  
  # respond_to do |format|
  #   format.js { render :file => "/path/to/save.js.erb" }
# end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
