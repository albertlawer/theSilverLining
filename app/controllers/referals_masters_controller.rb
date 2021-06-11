class ReferalsMastersController < ApplicationController
  before_action :set_referals_master, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_filter :load_permissions

  # GET /referals_masters
  # GET /referals_masters.json
  def index
    @referals_masters = ReferalsMaster.all
  end

  # GET /referals_masters/1
  # GET /referals_masters/1.json
  def show
  end

  # GET /referals_masters/new
  def new
    @referals_master = ReferalsMaster.new
  end

  # GET /referals_masters/1/edit
  def edit
  end

  # POST /referals_masters
  # POST /referals_masters.json
  def create
    @referals_master = ReferalsMaster.new(referals_master_params)

    respond_to do |format|
      if @referals_master.save
        format.html { redirect_to @referals_master, notice: 'Referals master was successfully created.' }
        format.json { render :show, status: :created, location: @referals_master }
      else
        format.html { render :new }
        format.json { render json: @referals_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referals_masters/1
  # PATCH/PUT /referals_masters/1.json
  def update
    respond_to do |format|
      if @referals_master.update(referals_master_params)
        format.html { redirect_to @referals_master, notice: 'Referals master was successfully updated.' }
        format.json { render :show, status: :ok, location: @referals_master }
      else
        format.html { render :edit }
        format.json { render json: @referals_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referals_masters/1
  # DELETE /referals_masters/1.json
  def destroy
    @referals_master.destroy
    respond_to do |format|
      format.html { redirect_to referals_masters_url, notice: 'Referals master was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referals_master
      @referals_master = ReferalsMaster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def referals_master_params
      params.require(:referals_master).permit(:user_id, :refered_user_id, :status)
    end
end
