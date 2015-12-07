class VaneUFOReport

  def self.execute(start_time, end_time, device_ip)
    logs = find_files(start_time, end_time)
    logs.each do |item|
      fetch(item, device_ip)
    end
  end

  def self.find_files(start_time, end_time)
    return [] if start_time.nil? || end_time.nil?
    start_date = Date.parse(start_time)
    end_date = Date.parse(end_time)
    files = []
    Dir.glob("/mnt/nodejs-tcp-watcher/log/receive.log.*").each do |item|
      date_str = item.split('/')[-1].split('.')[-1]
      date_time = Date.parse(date_str)
      files << item if date_time >= start_date && date_time <= end_date
    end
    files
  end

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
end
