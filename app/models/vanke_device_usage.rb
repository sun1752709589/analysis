class VankeDeviceUsage < ActiveRecord::Base
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
