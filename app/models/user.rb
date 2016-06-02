class User < ActiveRecord::Base
  # belongs_to :department
  has_many :tickets,:foreign_key=>'user_id',:class_name=>'Ticket'
  has_many :staff_tickets,:foreign_key=>'staff_id',:class_name=>'Ticket'
  has_many :staff_ticket_status
  has_many :conversations, :foreign_key => :sender_id
  # has_one :staff
  belongs_to :department
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable#,:confirmable#(To avoid the email verification
         
  enum role: [:Admin,:Staff,:Customer] 
  scope :chatted_users, lambda { |id| where(:id => id) }
  # after_initialize :set_default_values

  def set_default_values
    self.role ||=:Customer 
  end
end
