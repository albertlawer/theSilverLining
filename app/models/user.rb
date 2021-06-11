class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :timeout_in => 15.minutes
         
         
  belongs_to :role
  
  def super_admin?
    self.role.name == "Admin"
  end
         
  after_create :validate_ref_code
  after_create :generate_user_code
  after_create :generate_user_balance
  after_create :send_sms

  validates :last_name, presence: true
  validates :other_names, presence: true
  validates :contact_number, presence: true
  validates :username, presence: true
  validates :role_id, presence: true
  
  
  
  def generate_user_balance
    AccountMaster.create!(
        user_id: self.id,
        avaliable_balance:  0.00,
        status: true
      )
  end
  
  def generate_user_code
    client_code = loop do
                    token = SecureRandom.base64(10)
                    break token unless User.exists?(ref_code: token)
                  end
    User.update(self.id, :ref_code => client_code)
  end
  
  def validate_ref_code
    if self.referer_code.present?
      the_status = User.exists?(ref_code: self.referer_code)
      if !the_status
        User.update(self.id, :referer_code => "")
      else
        the_id = User.where(ref_code: self.referer_code).pluck(:id)[0]
        ReferalsMaster.create!(
          user_id: self.id,
          refered_user_id: the_id,
          status: true
        )
      end
    end
  end
  
  def send_sms
    Thread.new{
              @sms_msg = "Hello #{self.other_names}. Thank you for registering with The Silver Lining. Earn more with us. Thank you."
              RequestMaster.sendsms(self.contact_number,@sms_msg,RequestMaster.genUniqueCode)
            }
  end

end
