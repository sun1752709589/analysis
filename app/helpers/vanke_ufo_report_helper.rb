module VankeUfoReportHelper
  def get_everyday_lighting_hour_data
    @everyday_lighting_hour.each do |k,v|
      if v.include?('分钟')
        @everyday_lighting_hour[k] = (v.to_f/60).round(2)
      end
      @everyday_lighting_hour[k] = @everyday_lighting_hour[k].to_f
    end
    [{name: "每天累计照明时间(单位:小时)", data: @everyday_lighting_hour}]
  end
  def get_everyday_hour_linghing_hour(date)
    data = @everyhour_lighting_hour.select{|k,v| k.include?(date)}.inject({}){|hash,(k,v)| hash.merge(k[11..13]+"时"=>v)}
    (0..23).each do |i|
      i = i.to_s
      i = '0' + i if i.size == 1
      i = i + '时'
      data[i] = 0 if data[i].nil?
    end
    [{name: "#{date}(#{Tool.num2week(Date.parse(date).wday)})照明时长分布(单位:秒)", data: data.sort.to_h}]
  end
  def get_everyday_hour_linghing_on(date)
    data = @everyhour_lighting_on.select{|k,v| k.include?(date)}.inject({}){|hash,(k,v)| hash.merge(k[11..13]+"时"=>v)}
    (0..23).each do |i|
      i = i.to_s
      i = '0' + i if i.size == 1
      i = i + '时'
      data[i] = 0 if data[i].nil?
    end
    [{name: "#{date}(#{Tool.num2week(Date.parse(date).wday)})累计开启次数分布(单位:次)", data: data.sort.to_h}]
  end
end
