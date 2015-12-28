class VankeReportController < ApplicationController
  def index
    @heater_usage_overview = VankeDeviceUsage.device_usage_overview('heater','2015-11-08','2015-12-12')
    @ecotower_usage_overview = VankeDeviceUsage.device_usage_overview('ecotower','2015-11-08','2015-12-12')
    @heater_usage_by_day = VankeDeviceUsage.device_usage_by_day('heater','2015-11-08','2015-12-12')
    @ecotower_usage_by_day = VankeDeviceUsage.device_usage_by_day('ecotower','2015-11-08','2015-12-12')
    @door_accesses_usage_by_day = VankeDeviceUsage.door_accesses_usage_by_day('2015-11-08','2015-12-12')
    @door_accesses_usage_by_hour = VankeDeviceUsage.door_accesses_usage_by_hour('2015-11-08','2015-12-12')

  end
end
