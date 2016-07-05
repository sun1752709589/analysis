class VankeDeviceUsage < ActiveRecord::Base
# scp -l 300 deployer@www.huantengsmart.com:/home/deployer/nginx_access_log/vanke_heater.log.2016-03-31 /Users/phantom/temp/vakan_ufo_report/vanke_heater.log.2016-03-31
# 内网 scp -p 12221 deployer@10.132.7.167:/home/deployer/nginx_access_log/vanke_heater.log.2016-06-30 /home/deployer/sun_vanke_log/
# 内网 scp -p 12221 deployer@10.132.7.167:/home/deployer/nginx_access_log/vanke_ecotower.log.2016-06-30 /home/deployer/sun_vanke_log/
# 内网 scp -p 12221 deployer@10.132.7.167:/home/deployer/nginx_access_log/vanke_dooraccesses.log.2016-06-30 /home/deployer/sun_vanke_log/
  # app控制和墙面开关控制热水器
  def self.device_usage_through_app_switch(device_type, start_time, end_time)
    app = {}
    switch = {}
    records = VankeDeviceUsage.where(created_at: Date.parse(start_time)..Date.parse(end_time)).where(device_type: device_type)
    records.each do |item|
      tmp = item.created_at.to_s[0..9]
      if item.mobile_type.include?('Android')
        app[tmp] = 0 if app[tmp].nil?
        app[tmp] += 1
      else
        switch[tmp] = 0 if switch[tmp].nil?
        switch[tmp] += 1
      end
    end
    (Date.parse(start_time)..(Date.parse(end_time)-1)).each do |x|
      date = x.to_s
      app[date] = 0 if app[date].nil?
      switch[date] = 0 if switch[date].nil?
    end
    [app.sort.to_h, switch.sort.to_h]
  end

  # 热水器-空调-by hour
  def self.device_usage_by_hour(device_type, start_time, end_time)
    work_day = {}
    weekend = {}
    records = VankeDeviceUsage.where(created_at: Date.parse(start_time)..Date.parse(end_time)).where(device_type: device_type)
    records.each do |item|
      week = item.created_at.wday
      hour = item.created_at.hour
      if [0,6].include?(week)
        weekend[hour] = [] if weekend[hour].nil?
        weekend[hour] << item.device_id unless weekend[hour].include?(item.device_id)
      else
        work_day[hour] = [] if work_day[hour].nil?
        work_day[hour] << item.device_id unless work_day[hour].include?(item.device_id)
      end
    end
    work_day.each{|k,v| work_day[k]=v.size}
    weekend.each{|k,v| weekend[k]=v.size}
    (0..23).each do |i|
      work_day[i] = 0 if work_day[i].nil?
      weekend[i] = 0 if weekend[i].nil?
    end
    [work_day.sort_by{|k,v| k.to_i}.to_h,weekend.sort_by{|k,v| k.to_i}.to_h]
  end

  # 门禁使用-by hour
  def self.door_accesses_usage_by_hour(start_time, end_time)
    door_open = {}
    door_share = {}
    records = VankeDeviceUsage.where(created_at: Date.parse(start_time)..Date.parse(end_time)).where(device_type: 'dooraccesses')
    records.each do |item|
      tmp = item.created_at.hour#.to_s + "时"
      if 'open' == item.operation
        door_open[tmp] = 0 if door_open[tmp].nil?
        door_open[tmp] += 1
      elsif 'create_share_url' == item.operation
        door_share[tmp] = 0 if door_share[tmp].nil?
        door_share[tmp] += 1
      end
    end
    (0..23).each do |i|
      # i = i.to_s + "时"
      door_open[i] = 0 if door_open[i].nil?
      door_share[i] = 0 if door_share[i].nil?
    end
    # binding.pry
    [door_open.sort_by{|k,v| k.to_i}.to_h, door_share.sort_by{|k,v| k.to_i}.to_h]
  end
  # 门禁使用-by day
  def self.door_accesses_usage_by_day(start_time, end_time)
    door_open = {}
    door_share = {}
    records = VankeDeviceUsage.where(created_at: Date.parse(start_time)..Date.parse(end_time)).where(device_type: 'dooraccesses')
    records.each do |item|
      tmp = item.created_at.to_s[0..9]
      if 'open' == item.operation
        door_open[tmp] = 0 if door_open[tmp].nil?
        door_open[tmp] += 1
      elsif 'create_share_url' == item.operation
        door_share[tmp] = 0 if door_share[tmp].nil?
        door_share[tmp] += 1
      end
    end
    (Date.parse(start_time)..(Date.parse(end_time)-1)).each do |x|
      date = x.to_s
      door_open[date] = 0 if door_open[date].nil?
      door_share[date] = 0 if door_share[date].nil?
    end
    [door_open.sort.to_h, door_share.sort.to_h]
  end

  # 热水器使用房间数-by day
  def self.device_usage_by_day(device_type, start_time, end_time)
    result = {}
    # vanke_heater_ids = VankeDeviceHouseTable.where("device_type='bulb'").map(&:device_id)
    records = VankeDeviceUsage.where(created_at: Date.parse(start_time)..Date.parse(end_time)).where(device_type: device_type)
    records.each do |item|
      tmp = item.created_at.to_s[0..9]
      result[tmp] = [] if result[tmp].nil?
      result[tmp] << item.device_id unless result[tmp].include?(item.device_id)
    end
    (Date.parse(start_time)..(Date.parse(end_time)-1)).each do |x|
      date = x.to_s
      result[date] = 0 if result[date].nil?
    end
    result.each{|k,v| result[k]=v.size}
    result.sort.to_h
  end

  # 热水器使用概览
  def self.device_usage_overview(device_type, start_time, end_time)
    result = {}
    vanke_heater_ids = VankeDeviceHouseTable.where("device_type='#{device_type}'").map(&:device_id)
    records = VankeDeviceUsage.where(created_at: Date.parse(start_time)..Date.parse(end_time)).where(device_type: device_type)
    records.each do |item|
      result[item.device_id] = [] if result[item.device_id].nil?
      tmp = item.created_at.to_s[0..9]
      result[item.device_id] << tmp unless result[item.device_id].include?(tmp)
    end
    a = ["未使用",'0',(vanke_heater_ids-result.keys).size,((vanke_heater_ids-result.keys).size.to_f/vanke_heater_ids.size).round(2)]
    b = ["普通使用",'1-9天',(result.select{|k,v| v.size < 10}).size,((result.select{|k,v| v.size < 10}).size.to_f/vanke_heater_ids.size).round(2)]
    c = ["高频使用",'>10天',(result.select{|k,v| v.size >= 10}).size,((result.select{|k,v| v.size >= 10}).size.to_f/vanke_heater_ids.size).round(2)]
    [a,b,c]
  end

  # zgrep --no-filename switch_o access.log.[2-5].gz >> /home/deployer/nginx_access_log/vanke_heater.log.2016-06-30
  # grep --no-filename switch_o access.log access.log.1 >> /home/deployer/nginx_access_log/vanke_heater.log.2016-06-30
  # VankeDeviceUsage.fetch_heater_data('2016-06-01', '2016-06-30')
  def self.fetch_heater_data(start_time, end_time, vanke_only = true)
    vanke_heater_ids = VankeDeviceHouseTable.where("device_type='heater'").map(&:device_id)
    files = Tool.find_files("/Users/phantom/temp/vakan_ufo_report", "vanke_heater.log.*", start_time, end_time)
    error_count = 0
    files.each do |file_path|
      IO.foreach(file_path) do |line|
        begin
          # binding.pry
          next if line.size < 10 || line.include?('/api/api_v1')
          time = /\[.*\]/.match(line)[0][1...-1].sub(/:/, " ").to_datetime
          device_id = /bulbs\/\d+/.match(line)[0].split('/')[1]
          next if vanke_only && !vanke_heater_ids.include?(device_id.to_i)
          device_type = 'heater'
          method = /.{4,5}\/api/.match(line)[0].split(' ')[0]
          operation = /bulbs\/\d+.*\.json/.match(line)[0].split('/')[-1].split('.')[0]
          request_url = /\/api.*\.json/.match(line)[0]
          mobile_type = /"-".*/.match(line)[0][5..-2]
          VankeDeviceUsage.find_or_create_by({device_id: device_id, device_type: device_type,
            method: method, operation: operation, request_url: request_url, created_at: time, mobile_type: mobile_type
            })
        rescue
          error_count += 1
          next
        end
      end
    end
    puts "总错误数:#{error_count}"
    ErrorCount.create({error_type: 'error',error_count: error_count,file_path: nil,key_word: 'heater',created_at: Time.now})
    "总错误数:#{error_count}"
  end
  # zgrep --no-filename vanke_eco_towers access.log.[2-5].gz >> /home/deployer/nginx_access_log/vanke_ecotower.log.2016-06-30
  # zgrep --no-filename vanke_eco_towers access.log access.log.1 >> /home/deployer/nginx_access_log/vanke_ecotower.log.2016-06-30
  # VankeDeviceUsage.fetch_ecotower_data('2016-06-01', '2016-06-30')
  def self.fetch_ecotower_data(start_time, end_time, vanke_only = true)
    vanke_ecotower_ids = VankeDeviceHouseTable.where("device_type='ecotower'").map(&:device_id)
    files = Tool.find_files("/Users/phantom/temp/vakan_ufo_report", "vanke_ecotower.log.*", start_time, end_time)
    error_count = 0
    files.each do |file_path|
      IO.foreach(file_path) do |line|
        begin
          next if line.size < 10 || line.include?('/api/api_v1')
          time = /\[.*\]/.match(line)[0][1...-1].sub(/:/, " ").to_datetime
          device_id = /vanke_eco_towers\/\d+/.match(line)[0].split('/')[1]
          next if vanke_only && !vanke_ecotower_ids.include?(device_id.to_i)
          device_type = 'ecotower'
          method = /.{4,5}\/api/.match(line)[0].split(' ')[0]
          # operation = /bulbs\/\d+.*\.json/.match(line)[0].split('/')[-1].split('.')[0]
          request_url = /\/api.*\.json/.match(line)[0]
          mobile_type = /"-".*/.match(line)[0][5..-2]
          VankeDeviceUsage.find_or_create_by({device_id: device_id, device_type: device_type,
            method: method, request_url: request_url, created_at: time, mobile_type: mobile_type
            })
        rescue
          error_count += 1
          next
        end
      end
    end
    puts "总错误数:#{error_count}"
    ErrorCount.create({error_type: 'error',error_count: error_count,file_path: nil,key_word: 'ecotower',created_at: Time.now})
    "总错误数:#{error_count}"
  end
  # zgrep --no-filename door_accesses access.log.[2-5].gz >> /home/deployer/nginx_access_log/vanke_dooraccesses.log.2016-06-30
  # zgrep --no-filename door_accesses access.log access.log.1 >> /home/deployer/nginx_access_log/vanke_dooraccesses.log.2016-06-30
  # VankeDeviceUsage.fetch_dooraccesses_data('2016-06-01', '2016-06-30')
  def self.fetch_dooraccesses_data(start_time, end_time, vanke_only = true)
    vanke_dooraccesses_ids = VankeDeviceHouseTable.where("device_type='dooraccesses'").map(&:device_id)
    files = Tool.find_files("/Users/phantom/temp/vakan_ufo_report", "vanke_dooraccesses.log.*", start_time, end_time)
    error_count = 0
    files.each do |file_path|
      IO.foreach(file_path) do |line|
        begin
          next if line.size < 10 || line.include?('/api/api_v1')
          time = /\[.*\]/.match(line)[0][1...-1].sub(/:/, " ").to_datetime
          device_id = /door_accesses\/\d+/.match(line)[0].split('/')[1]
          # next if vanke_only && !vanke_dooraccesses_ids.include?(device_id.to_i)
          device_type = 'dooraccesses'
          method = /.{4,5}?\/api/.match(line)[0].split(' ')[0].sub(/"/, "")
          operation = /door_accesses\/\d+.*\.json/.match(line)[0].split('/')[-1].split('.')[0]
          request_url = /\/api.*\.json/.match(line)[0]
          mobile_type = /"-".*/.match(line)[0][5..-2]
          VankeDeviceUsage.find_or_create_by({device_id: device_id, device_type: device_type,
            method: method, request_url: request_url, operation: operation, created_at: time, mobile_type: mobile_type
            })
        rescue Exception => e
          error_count += 1
          next
        end
      end
    end
    puts "总错误数:#{error_count}"
    ErrorCount.create({error_type: 'error',error_count: error_count,file_path: nil,key_word: 'dooraccesses',created_at: Time.now})
    "总错误数:#{error_count}"
  end
end
