class VankeDeviceUsage < ActiveRecord::Base
  # VankeDeviceUsage.fetch_heater_data('2015-12-01', '2015-12-30')
  def self.fetch_heater_data(start_time, end_time, vanke_only = true)
    vanke_heater_ids = VankeDeviceHouseTable.where("device_type='bulb'").map(&:device_id)
    files = Tool.find_files("/Users/phantom/temp/vakan_ufo_report", "vanke_heater.log.*", start_time, end_time)
    files.each do |file_path|
      IO.foreach(file_path) do |line|
        begin
          binding.pry

        rescue
          next
        end
      end
    end
  end

end
