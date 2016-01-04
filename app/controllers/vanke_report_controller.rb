class VankeReportController < ApplicationController
  def index
    @start_time = '2015-11-08'
    @end_time = '2015-12-12'
    @heater_usage_overview = VankeDeviceUsage.device_usage_overview('heater',@start_time,@end_time)
    @ecotower_usage_overview = VankeDeviceUsage.device_usage_overview('ecotower',@start_time,@end_time)
    @heater_usage_by_day = VankeDeviceUsage.device_usage_by_day('heater',@start_time,@end_time)
    @ecotower_usage_by_day = VankeDeviceUsage.device_usage_by_day('ecotower',@start_time,@end_time)
    @door_accesses_usage_by_day = VankeDeviceUsage.door_accesses_usage_by_day(@start_time,@end_time)
    @door_accesses_usage_by_hour = VankeDeviceUsage.door_accesses_usage_by_hour(@start_time,@end_time)
    @heater_usage_by_hour = VankeDeviceUsage.device_usage_by_hour('heater',@start_time,@end_time)
    @ecotower_usage_by_hour = VankeDeviceUsage.device_usage_by_hour('ecotower',@start_time,@end_time)
    @heater_usage_by_control_type = VankeDeviceUsage.device_usage_through_app_switch('heater',@start_time,@end_time)
    @ecotower_usage_by_control_type = VankeDeviceUsage.device_usage_through_app_switch('ecotower',@start_time,@end_time)
    # binding.pry
  end
end
