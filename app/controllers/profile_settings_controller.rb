class ProfileSettingsController < ApplicationController
  before_action :set_profile_setting, only: [:show, :edit, :update, :destroy]

  def index
    @profile_settings = ProfileSetting.all
  end

  def show; end

  def new
    @profile_setting = ProfileSetting.new
  end

  def create
    @profile_setting = ProfileSetting.new(profile_setting_params)
    if @profile_setting.save
      redirect_to @profile_setting, notice: "Profile created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @profile_setting.update(profile_setting_params)
      redirect_to @profile_setting, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile_setting.destroy
    redirect_to profile_settings_path, notice: "Profile deleted successfully."
  end

  private

  def set_profile_setting
    @profile_setting = ProfileSetting.find(params[:id])
  end

  def profile_setting_params
    params.require(:profile_setting).permit(:company_name, :address, :gst_number, :email, :phone)
  end
end
