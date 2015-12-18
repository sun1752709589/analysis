class DeviceInfo < ActiveRecord::Base

  def dump_energy
    vi = self.version_info
    if !vi.nil? && (vi.length == 8 * 2 || vi.length == 12 * 2)
      voltage = ((vi[-2, 2] + vi[-4, 2]).to_i(16) / 4096.0 * 3.6).round(2)
      voltage
    end
  end

  def self.get_energy_by_device_type(device_type, threshold = 0)
    return {} unless ['door_sensor','infrared_sensor','switch'].include?(device_type)
    result = {}
    device_infos = DeviceInfo.all
    device_infos.each do |item|
      vi = item.version_info
      if !vi.nil? && (vi.length == 8 * 2 || vi.length == 12 * 2)
        result[item.device_ip] = item.dump_energy
      end
    end
    result
  end
end
