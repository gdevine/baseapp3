class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  before_save { self.email = email.downcase }
  after_create :send_welcome_mail, :send_admin_mail
  
  # Set out different user roles available
  def self.roles
    ['user', 'superuser', 'admin']
  end
         
  validates :firstname, :presence => { :message => "You must give a First Name" }, length: { maximum: 30 }
  validates :surname, :presence => { :message => "You must give a Surname" }, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => { :message => "An account with this email already exists" }, length: { maximum: 80 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  validates_inclusion_of :role, in: self.roles
  validate :name_has_no_numbers
  
  ## Custom validations
  def name_has_no_numbers
    errors.add(:base, "First Name or Surname can not contain numbers") if
      /\d/.match( self.firstname ) || /\d/.match( self.surname )
  end
  
  # Devise 'approved' settings
  def active_for_authentication? 
    super && approved? 
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end
  
  def send_admin_mail
    AdminMailer.new_user_waiting_for_approval(self).deliver_now
    # AdminMailer.new_user_waiting_for_approval(self)
  end
  
  def send_welcome_mail
    UserMailer.welcome_email(self).deliver_now
    # UserMailer.welcome_email(self)
  end
  
  def fullname
    self.firstname.capitalize + " " + self.surname.capitalize
  end
  
  
end
