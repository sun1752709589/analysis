class VankeDeviceUsage < ActiveRecord::Base

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
    [work_day.sort.to_h,weekend.sort.to_h]
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

  # zgrep switch_o access.log.[1-5].gz >> vanke_heater.log.2015-12-14
  # VankeDeviceUsage.fetch_heater_data('2015-12-01', '2015-12-30')
  def self.fetch_heater_data(start_time, end_time, vanke_only = true)
    vanke_heater_ids = VankeDeviceHouseTable.where("device_type='bulb'").map(&:device_id)
    files = Tool.find_files("/Users/phantom/temp/vakan_ufo_report", "vanke_heater.log.*", start_time, end_time)
    files.each do |file_path|
      IO.foreach(file_path) do |line|
        begin
          time = /\[.*\]/.match(line)[0][1...-1].sub(/:/, " ").to_datetime
          device_id = /bulbs\/\d+/.match(line)[0].split('/')[1]
          next if vanke_only && !vanke_heater_ids.include?(device_id.to_i)
          device_type = 'heater'
          method = /.{4,5}\/api/.match(line)[0].split(' ')[0]
          operation = /bulbs\/\d+.*\.json/.match(line)[0].split('/')[-1].split('.')[0]
          request_url = /\/api.*\.json/.match(line)[0]
          # mobile_type = /\(.*\)/.match(line)[0][1...-1]
          VankeDeviceUsage.find_or_create_by({device_id: device_id, device_type: device_type,
            method: method, operation: operation, request_url: request_url, created_at: time
            })
        rescue
          next
        end
      end
    end
  end
  # zgrep vanke_eco_towers access.log.[1-5].gz >> vanke_ecotower.log.2015-12-08
  # VankeDeviceUsage.fetch_ecotower_data('2015-12-01', '2015-12-30')
  def self.fetch_ecotower_data(start_time, end_time, vanke_only = true)
    vanke_ecotower_ids = VankeDeviceHouseTable.where("device_type='ecotower'").map(&:device_id)
    files = Tool.find_files("/Users/phantom/temp/vakan_ufo_report", "vanke_ecotower.log.*", start_time, end_time)
    files.each do |file_path|
      IO.foreach(file_path) do |line|
        begin
          time = /\[.*\]/.match(line)[0][1...-1].sub(/:/, " ").to_datetime
          device_id = /vanke_eco_towers\/\d+/.match(line)[0].split('/')[1]
          next if vanke_only && !vanke_ecotower_ids.include?(device_id.to_i)
          device_type = 'ecotower'
          method = /.{4,5}\/api/.match(line)[0].split(' ')[0]
          # operation = /bulbs\/\d+.*\.json/.match(line)[0].split('/')[-1].split('.')[0]
          request_url = /\/api.*\.json/.match(line)[0]
          # mobile_type = /\(.*\)/.match(line)[0][1...-1]
          VankeDeviceUsage.find_or_create_by({device_id: device_id, device_type: device_type,
            method: method, request_url: request_url, created_at: time
            })
        rescue
          next
        end
      end
    end
  end
  # zgrep door_accesses access.log.[1-5].gz >> vanke_dooraccesses.log.2015-12-09
  # VankeDeviceUsage.fetch_dooraccesses_data('2015-12-01', '2015-12-30')
  def self.fetch_dooraccesses_data(start_time, end_time, vanke_only = true)
    vanke_dooraccesses_ids = VankeDeviceHouseTable.where("device_type='dooraccesses'").map(&:device_id)
    files = Tool.find_files("/Users/phantom/temp/vakan_ufo_report", "vanke_dooraccesses.log.*", start_time, end_time)
    files.each do |file_path|
      IO.foreach(file_path) do |line|
        begin
          time = /\[.*\]/.match(line)[0][1...-1].sub(/:/, " ").to_datetime
          device_id = /door_accesses\/\d+/.match(line)[0].split('/')[1]
          # next if vanke_only && !vanke_dooraccesses_ids.include?(device_id.to_i)
          device_type = 'dooraccesses'
          method = /.{4,5}?\/api/.match(line)[0].split(' ')[0].sub(/"/, "")
          operation = /door_accesses\/\d+.*\.json/.match(line)[0].split('/')[-1].split('.')[0]
          request_url = /\/api.*\.json/.match(line)[0]
          # mobile_type = /\(.*\)/.match(line)[0][1...-1]
          VankeDeviceUsage.find_or_create_by({device_id: device_id, device_type: device_type,
            method: method, request_url: request_url, operation: operation, created_at: time
            })
        rescue
          next
        end
      end
    end
  end
end
