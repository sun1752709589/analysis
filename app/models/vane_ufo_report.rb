# grep -h 40465 receive.log.2015-12-*  >> ./sun_usage_log/vanke_ufo_report.log.2015-12-21
class VaneUFOReport
  # usage:VaneUFOReport.execute('2015-12-01', '2015-12-30', 40465)
  # 得到每次开灯时长
  def self.get_by_hash(start_time, end_time, device_ip)
    hash = {}
    data = Bulb.where({device_ip: device_ip, created_at: Date.parse(start_time)..Date.parse(end_time), op_code: 'Ri', care_word: 'f'}).order("created_at")
    data.each do |item|
      next if item.created_at.nil?
      off = Bulb.where({device_ip: device_ip, op_code: 'Ri', care_word: '0'}).where("created_at >= '#{item.created_at}'").order("created_at").first
      next if off.nil?
      if (off.created_at.to_i - item.created_at.to_i) < 600
        hash[item.created_at.to_s[0...19]] = off.created_at.to_i - item.created_at.to_i
      end
    end
    hash
  end

  def self.execute(start_time, end_time, device_ip)
    # logs = Tool.find_files("/Users/phantom/temp/vakan_ufo_report/receive_log", "vanke_ufo_report.log.*", start_time, end_time)
    # logs.each do |item|
    #   fetch(item, device_ip)
    # end
    hash = get_by_hash(start_time, end_time, device_ip)
    # draw_chart(hash)
    hash
  end
  # 画图表
  def self.draw_chart(hash)
    everyday_lighting_hour = per_day_lighting_hour(hash)
    everyday_lighting_hour_second = per_day_lighting_hour(hash, true)
    everyday_lighting_on = per_day_lighting_on(hash)
    everyhour_lighting_hour = per_hour_lighting_hour(hash)
    everyhour_lighting_on = per_hour_lighting_on(hash)
    p = Axlsx::Package.new
    wb = p.workbook
    # ---
    # 每日累计照明时间
    wb.add_worksheet(:name => "每日累计照明时间") do |sheet|
      sheet.add_row ["日期","总时长"]
      everyday_lighting_hour.each do |k,v|
        sheet.add_row [k,v]
      end
      avg = (Tool.second2hour(everyday_lighting_hour_second.values.sum).to_f/everyday_lighting_hour.size).round(2)
      sheet.add_row ["均值","#{avg}小时"]
    end
    # 每日开启次数&每次平均照明时长
    wb.add_worksheet(:name => "每日开启次数&每次平均照明时长") do |sheet|
      sheet.add_row ["日期","开启次数","每次平均时长"]
      everyday_lighting_hour_second.each do |k,v|
        sheet.add_row [k,everyday_lighting_on[k].to_s + "次",(v/everyday_lighting_on[k]).round(0).to_s + "秒"]
      end
      avg = (everyday_lighting_hour.values.map(&:to_f).sum/everyday_lighting_hour.size).round(2)
      sheet.add_row ["均值","#{(everyday_lighting_on.values.sum/everyday_lighting_on.size).round(0)}次","#{(everyday_lighting_hour_second.values.sum/everyday_lighting_on.values.sum).round(0)}秒"]
    end
    # 每日累计照明时长-by hour
    wb.add_worksheet(:name => "每日累计照明时长-by hour") do |sheet|
      tmp = ""
      everyhour_lighting_hour.each do |k,v|
        if k[0..9] != tmp
          sheet.add_row ["日期","小时","照明时长","开启次数"]
          tmp = k[0..9]
        end
        sheet.add_row [k[0..9],k[11..12],Tool.second2hour(v),everyhour_lighting_on[k]]
      end
    end
    # 照明时长最长的10次明细信息
    wb.add_worksheet(:name => "照明时长最长的10次明细信息") do |sheet|
      top10 = hash.sort_by{ |k,v| v }.reverse.first(10)
      sheet.add_row ["日期","星期","开启时间","照明时长"]
      top10.each do |item|
        sheet.add_row [item[0][0..9],Tool.num2week(Date.parse(item[0]).wday),item[0][11..19],Tool.second2hour(item[1])]
      end
    end
    # ---
    p.use_shared_strings = true
    p.serialize('chart.xlsx')
    binding.pry
  end
  # 将数据分析后存入数据库
  def self.fetch(file_path, device_ip)
    error_count = 0
    IO.foreach(file_path) do |line|
      begin
        data = JSON.parse(line)
        message = data['message']
        next if !message.include?("#{device_ip},Ri")
        created_at = DateTime.iso8601(data['timestamp'])
        msg_arr = message.split(',')
        op_code = msg_arr[2]
        instruction = msg_arr[3]
        care_word = msg_arr[3].try(:[], 4)
        last_care_word = Bulb.last.try(:care_word) || '0'
        next if care_word == last_care_word || care_word.nil?
        unless Bulb.where({device_ip: device_ip, created_at: created_at, op_code: op_code}).first
          Bulb.create({device_ip: device_ip, op_code: op_code, instruction: instruction, care_word: care_word, message: message, created_at: created_at})
        end
      rescue
        error_count += 1
        next
      end
    end
    puts "总错误数:#{error_count}"
    ErrorCount.create({error_type: 'error',error_count: error_count,file_path: file_path,key_word: device_ip,created_at: Time.now})
  end

  # 每天照明时长
  def self.per_day_lighting_hour(hash, second = false)
    result = {}
    hash.each do |k, v|
      result[k[0..9]] = 0 if result[k[0..9]].nil?
      result[k[0..9]] += v.to_i
    end
    unless second
      result.each do |k, v|
        result[k] = Tool.second2hour(v)
      end
    end
    result
  end

  # 每天开启次数
  def self.per_day_lighting_on(hash)
    result = {}
    hash.each do |k, v|
      result[k[0..9]] = 0 if result[k[0..9]].nil?
      result[k[0..9]] += 1
    end
    result
  end

  # 每小时照明时长
  def self.per_hour_lighting_hour(hash, second = false)
    result = {}
    hash.each do |k, v|
      result[k[0..12]] = 0 if result[k[0..12]].nil?
      result[k[0..12]] += v.to_i
    end
    if second
      result.each do |k, v|
        result[k] = Tool.second2hour(v)
      end
    end
    result
  end

  # 每小时开启次数
  def self.per_hour_lighting_on(hash)
    result = {}
    hash.each do |k, v|
      result[k[0..12]] = 0 if result[k[0..12]].nil?
      result[k[0..12]] += 1
    end
    result
  end

end
