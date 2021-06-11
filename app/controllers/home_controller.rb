class HomeController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:index]
  
  def index  
  end
  
  def dashboard
    if current_user.role_id == 1 #user
      @balance = AccountMaster.where(user_id: current_user.id).pluck(:avaliable_balance)[0]
      @referal_code = User.where(id: current_user.id).pluck(:ref_code)[0]
      @referal_no = ReferalsMaster.where(refered_user_id: current_user.id).count()
      @inv_no = InvestmentMaster.where(user_id: current_user.id, status: true).count()
  	  @inv_amt = InvestmentMaster.where(user_id: current_user.id, status: true).sum(:amount_invested)
    elsif current_user.role_id == 2 #admin
      @bal_list = RequestMaster.checkBal
      @active_investments = InvestmentMaster.where(status: true).count()
      @inactive_investments = InvestmentMaster.where(status: false).count()
    end
  end
end
