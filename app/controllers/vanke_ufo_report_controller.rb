class VankeUfoReportController < ApplicationController
  def index
    hash = VaneUFOReport.execute('2015-12-01', '2015-12-21', 40465)
    @everyday_lighting_hour = VaneUFOReport.per_day_lighting_hour(hash)
    @everyday_lighting_hour_second = VaneUFOReport.per_day_lighting_hour(hash, true)
    @everyday_lighting_on = VaneUFOReport.per_day_lighting_on(hash)
    @everyhour_lighting_hour = VaneUFOReport.per_hour_lighting_hour(hash)
    @everyhour_lighting_on = VaneUFOReport.per_hour_lighting_on(hash)
  end
end
