class SystemConfigsController < ApplicationController
  before_action :set_system_config, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  before_filter :load_permissions

  # GET /system_configs
  # GET /system_configs.json
  def index
    @system_configs = SystemConfig.all
  end

  # GET /system_configs/1
  # GET /system_configs/1.json
  def show
  end

  # GET /system_configs/new
  def new
    @system_config = SystemConfig.new
  end

  # GET /system_configs/1/edit
  def edit
  end

  # POST /system_configs
  # POST /system_configs.json
  def create
    @system_config = SystemConfig.new(system_config_params)

    respond_to do |format|
      if @system_config.save
        format.html { redirect_to system_configs_path, notice: 'System config was successfully created.' }
        format.json { render :show, status: :created, location: @system_config }
      else
        format.html { render :new }
        format.json { render json: @system_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system_configs/1
  # PATCH/PUT /system_configs/1.json
  def update
    respond_to do |format|
      if @system_config.update(system_config_params)
        format.html { redirect_to system_configs_path, notice: 'System config was successfully updated.' }
        format.json { render :show, status: :ok, location: @system_config }
      else
        format.html { render :edit }
        format.json { render json: @system_config.errors, status: :unprocessable_entity }
      end
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_config
      @system_config = SystemConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_config_params
      params.require(:system_config).permit(:name, :desc, :value, :status)
    end
end
