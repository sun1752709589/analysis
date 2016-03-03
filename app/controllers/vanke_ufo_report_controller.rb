class VankeUfoReportController < ApplicationController
  def index
    @start_time = '2016-02-01'
    @end_time = '2016-03-01'
    @hash = VaneUFOReport.get_by_hash(@start_time, @end_time, 40465)
    @everyday_lighting_hour = VaneUFOReport.per_day_lighting_hour(@hash)
    @everyday_lighting_hour_second = VaneUFOReport.per_day_lighting_hour(@hash, true)
    @everyday_lighting_on = VaneUFOReport.per_day_lighting_on(@hash)
    @everyhour_lighting_hour = VaneUFOReport.per_hour_lighting_hour(@hash)
    @everyhour_lighting_on = VaneUFOReport.per_hour_lighting_on(@hash)
    # binding.pry
  end
end
