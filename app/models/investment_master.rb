class InvestmentMaster < ActiveRecord::Base
  before_create :create_transaction_code
  before_create :create_dates
  before_create :fill_percentages
  after_create :update_balance

  
  belongs_to :a_user, class_name: "User", foreign_key: :user_id
  
  validates :amount_invested,presence: true
  validate :avail_bal
  
  
  def create_transaction_code
    time=Time.new
    randval_one=rand(999).to_s.center(3, rand(9).to_s)
    strtm=time.strftime("%y%m%d%H%M%L")
    api_code = "TSL"+strtm+randval_one
    self.transaction_code = api_code
  end
  
  
  
  def create_dates
    days = SystemConfig.where(id: 1).pluck(:value)[0]
    days = days.to_i
    self.start_date = Time.now
    self.end_date = self.start_date + days.days
  end
  
  def fill_percentages
    client_per = SystemConfig.where(id: 2).pluck(:value)[0]
    ref_per = SystemConfig.where(id: 3).pluck(:value)[0]
    self.client_per = client_per
    self.ref_per = ref_per
  end
  
  def update_balance
    @accno = AccountMaster.where(user_id: self.user_id)#.pluck(:avaliable_balance)[0]
    current_bal = @accno[0]["avaliable_balance"]
    the_id = @accno[0]["id"]
    new_bal = current_bal.to_f - self.amount_invested.to_f
    AccountMaster.update(the_id, avaliable_balance: new_bal)
  end
  
  def avail_bal
    the_bal = AccountMaster.where(user_id: self.user_id).pluck(:avaliable_balance)[0]
    if self.amount_invested.to_f > the_bal.to_f
      self.errors.add(:amount_invested,"Amount is greater than availiable balance of GHS #{the_bal}")
    elsif self.amount_invested.to_f < 100
      self.errors.add(:amount_invested,"Amount to invest starts from GHS 100")
    end
  end
      
end
