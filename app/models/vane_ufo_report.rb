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
    logs = Tool.find_files("/Users/phantom/temp/vakan_ufo_report", "receive.log.*", start_time, end_time)
    logs.each do |item|
      fetch(item, device_ip)
    end
    hash = get_by_hash(start_time, end_time, device_ip)
    everyday_lighting_hour = per_day_lighting_hour(hash)
    everyday_lighting_hour_second = per_day_lighting_hour(hash, true)
    everyday_lighting_on = per_day_lighting_on(hash)
    everyhour_lighting_hour = per_hour_lighting_hour(hash)
    everyhour_lighting_on = per_hour_lighting_on(hash)
binding.pry
  end

  # 将数据分析后存入数据库
  def self.fetch(file_path, device_ip)
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
        unless Bulb.where({device_ip: device_ip, created_at: created_at, op_code: op_code}).first
          Bulb.create({device_ip: device_ip, op_code: op_code, instruction: instruction, care_word: care_word, message: message, created_at: created_at})
        end
      rescue
        next
      end
    end
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
