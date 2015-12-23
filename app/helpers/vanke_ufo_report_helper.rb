module VankeUfoReportHelper
  def get_everyday_lighting_hour_data
    @everyday_lighting_hour.each do |k,v|
      if v.include?('分钟')
        @everyday_lighting_hour[k] = (v.to_f/60).round(2)
      end
      @everyday_lighting_hour[k] = @everyday_lighting_hour[k].to_f
    end
    [{name: "每天累计照明时间", data: @everyday_lighting_hour}]
  end
end
