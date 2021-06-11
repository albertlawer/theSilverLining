class PaymentTablesController < ApplicationController
  before_action :set_payment_table, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_filter :load_permissions

  # GET /payment_tables
  # GET /payment_tables.json
  def index
    @payment_tables = PaymentTable.where(user_id: current_user.id) # profit
    @referals = PaymentTable.where(referer_user_id: current_user.id) #referals
    @deposits = RequestMaster.where(user_id: current_user.id, trans_type: "DR") #deposits
    @withdrawals = RequestMaster.where(user_id: current_user.id, trans_type: "CR") #withdrawals
  end

  def payment_tables_admin
    @payment_tables = PaymentTable.all # profit
  end

  # GET /payment_tables/1
  # GET /payment_tables/1.json
  def show
  end

  # GET /payment_tables/new
  def new
    @payment_table = PaymentTable.new
  end

  # GET /payment_tables/1/edit
  def edit
  end

  # POST /payment_tables
  # POST /payment_tables.json
  def create
    @payment_table = PaymentTable.new(payment_table_params)

    respond_to do |format|
      if @payment_table.save
        format.html { redirect_to @payment_table, notice: 'Payment table was successfully created.' }
        format.json { render :show, status: :created, location: @payment_table }
      else
        format.html { render :new }
        format.json { render json: @payment_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_tables/1
  # PATCH/PUT /payment_tables/1.json
  def update
    respond_to do |format|
      if @payment_table.update(payment_table_params)
        format.html { redirect_to @payment_table, notice: 'Payment table was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment_table }
      else
        format.html { render :edit }
        format.json { render json: @payment_table.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_tables/1
  # DELETE /payment_tables/1.json
  def destroy
    @payment_table.destroy
    respond_to do |format|
      format.html { redirect_to payment_tables_url, notice: 'Payment table was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_table
      @payment_table = PaymentTable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_table_params
      params.require(:payment_table).permit(:user_id, :referer_user_id, :investment_master_code, :client_profit, :referer_profit, :admin_profit, :status)
    end
end
