class InvestmentMastersController < ApplicationController
  before_action :set_investment_master, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_filter :load_permissions

  # GET /investment_masters
  # GET /investment_masters.json
  def index
    @investment_masters = InvestmentMaster.where(user_id: current_user.id)
  end

  def investment_masters_admin
    @investment_masters = InvestmentMaster.all
  end

  # GET /investment_masters/1
  # GET /investment_masters/1.json
  def show
  end

  # GET /investment_masters/new
  def new
    @investment_master = InvestmentMaster.new
  end

  # POST /investment_masters
  # POST /investment_masters.json
  def create
    @investment_master = InvestmentMaster.new(investment_master_params)

    respond_to do |format|
      if @investment_master.save
        @user = User.where(id: current_user.id)[0]
        Thread.new{
              @sms_msg = "Hello User. Your investment of GHS #{@investment_master.amount_invested} has been activated. Your Investment Code is #{@investment_master.transaction_code}. Thank you."
              RequestMaster.sendsms(@user["contact_number"],@sms_msg,RequestMaster.genUniqueCode)
            }
        format.html { redirect_to investment_masters_path, notice: 'Investment master was successfully created.' }
        format.json { render :show, status: :created, location: @investment_master }
      else
        format.html { render :new }
        format.json { render json: @investment_master.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_investment_master
      @investment_master = InvestmentMaster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def investment_master_params
      params.require(:investment_master).permit(:user_id, :amount_invested, :transaction_code, :start_date, :end_date, :status)
    end
end
