class AccountMastersController < ApplicationController
  before_action :set_account_master, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_filter :load_permissions

  # GET /account_masters
  # GET /account_masters.json
  def index
    @account_masters = AccountMaster.where(user_id: current_user.id)
  end

  # GET /account_masters/1
  # GET /account_masters/1.json
  def show
  end

  # GET /account_masters/new
  def new
    @account_master = AccountMaster.new
  end

  # GET /account_masters/1/edit
  def edit
  end

  # POST /account_masters
  # POST /account_masters.json
  def create
    @account_master = AccountMaster.new(account_master_params)

    respond_to do |format|
      if @account_master.save
        format.html { redirect_to @account_master, notice: 'Account master was successfully created.' }
        format.json { render :show, status: :created, location: @account_master }
      else
        format.html { render :new }
        format.json { render json: @account_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /account_masters/1
  # PATCH/PUT /account_masters/1.json
  def update
    respond_to do |format|
      if @account_master.update(account_master_params)
        format.html { redirect_to @account_master, notice: 'Account master was successfully updated.' }
        format.json { render :show, status: :ok, location: @account_master }
      else
        format.html { render :edit }
        format.json { render json: @account_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /account_masters/1
  # DELETE /account_masters/1.json
  def destroy
    @account_master.destroy
    respond_to do |format|
      format.html { redirect_to account_masters_url, notice: 'Account master was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account_master
      @account_master = AccountMaster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_master_params
      params.require(:account_master).permit(:user_id, :avaliable_balance, :status)
    end
end
