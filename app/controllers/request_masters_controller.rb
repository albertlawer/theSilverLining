class RequestMastersController < ApplicationController
  before_action :set_request_master, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_filter :load_permissions, except: [:amfp_callback]


  def request_masters_admin
    @request_masters = RequestMaster.all
  end


  # GET /request_masters
  # GET /request_masters.json
  def index
    @request_master = RequestMaster.new
  end

  # GET /request_masters/1
  # GET /request_masters/1.json
  def show
  end

  # GET /request_masters/new
  def new
    @request_master = RequestMaster.new
  end


  # POST /request_masters
  # POST /request_masters.json
  def create
    @request_master = RequestMaster.new(request_master_params)

    @request_master.user_id = current_user.id
    @request_master.trans_id = RequestMaster.genUniqueCode

    if @request_master.trans_type == "DR"
      the_amount = @request_master.amount
      final_amount = (0.02 * the_amount.to_f) + the_amount.to_f
      @request_master.total_amount = final_amount

    elsif @request_master.trans_type == "CR"
      @request_master.total_amount = @request_master.amount
    end
    
    respond_to do |format|
      if @request_master.save
        #push to amfp here
        if @request_master.trans_type == "DR"
          @msg = 'Deposit request was successfully created'
          Thread.new{
            RequestMaster.sendRequest(@request_master)
          }
        elsif @request_master.trans_type == "CR" 
          @bal_list = RequestMaster.checkBal
          the_rem_bal = @bal_list[@request_master.network]["Withdrawal"]
          @bal = the_rem_bal.split(" ")
          
          @msg = 'Withdrawal request was successfully created'
          
          if @bal[1].to_f >= @request_master.amount #can send request
            Thread.new{
              RequestMaster.sendRequest(@request_master)
            }
          else 
            #notify admin of the issue and tell admin to top up that wallet
            Thread.new{
              @sms_msg = "Hello Admin. Please note #{@request_master.network} balance is low for Trnx: #{@request_master.trans_id};"
              RequestMaster.sendsms("0209390147",@sms_msg,RequestMaster.genUniqueCode)
            }
          end
        end

        
        
        format.html { redirect_to request_masters_path, notice: @msg }
        format.json { render :show, status: :created, location: @request_master }
      else
        if @request_master.trans_type == "DR"
          format.html { render :new_dr }
          format.json { render json: @request_master.errors, status: :unprocessable_entity }
        elsif @request_master.trans_type == "CR"
          format.html { render :new_cr }
          format.json { render json: @request_master.errors, status: :unprocessable_entity }
        end
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request_master
      @request_master = RequestMaster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_master_params
      params.require(:request_master).permit(:user_id, :customer_number, :network, :trans_type, :item_desc, :trans_id, :amount, :total_amount, :status, :callback_status, :resp_code, :resp_desc, :voucher_code)
    end
end
