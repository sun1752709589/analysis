class EquipmentController < ApplicationController
  def index
    @user_devices = UserDevice.user_device_overview
  end
end
