class Ticket < ActiveRecord::Base
    # belongs_to :customer,:class_name=>'User',:foreign_key=>'customer_id'
    attr_accessor :check_history,:current_user_id
    # require 'securerandom'
    include Tokenable
    enum :status=> [:Waiting_for_Staff_Response,:Waiting_for_Customer,:on_hold,:cancelled,:completed] 
    before_create :generate_token, unless: :token?
    after_initialize :set_default_values
    after_update :status_and_ownership,:if=> Proc.new {|obj| obj.check_history == true}
    scope :search,-> (token) { where(:token => token)}
    has_many :ticket_replies,dependent: :destroy
    has_many :ticket_staff_statuses
    belongs_to :staff,:class_name=> 'User',:foreign_key=>'staff_id'
    belongs_to :user
    belongs_to :department
    validates :title,presence:{:message=>"Title can't be blank"}
    validates :body,presence:{:message=>"Body can't be blank"}
    
    def set_default_values
      self.status ||=:Waiting_for_Staff_Response 
    end
    
    def status_and_ownership
      self.ticket_staff_statuses.create('staff_id'=>self.staff_id,'status'=>self.status,'user_id'=>self.current_user_id)
    end  

    private
    
    # def generate_token
      
    #   self.token = SecureRandom.uuid
    # end

end
