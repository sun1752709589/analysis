class RouterOffline < ActiveRecord::Base
  # RouterOffline.execute('2015-12-01','2015-12-12')
  def self.execute(start_time, end_time)
    logs = Tool.find_files("/Users/phantom/temp/vakan_ufo_report", "receive.log.*", start_time, end_time)
    logs.each do |item|
      fetch(item)
    end
  end
  # 将数据分析后存入数据库
  def self.fetch(file_path)
    IO.foreach(file_path) do |line|
      begin
        data = JSON.parse(line)
        message = data['message']
        next if data['message'].split(',')[2] != "\u0001"
        device_ip = data['message'].split(',')[1]
        created_at = DateTime.iso8601(data['timestamp'])
        msg = data['message'].split(',')[3]
        unless RouterOffline.where({device_ip: device_ip, created_at: created_at, msg: msg}).first
          RouterOffline.create({device_ip: device_ip, created_at: created_at, msg: msg})
        end
      rescue
        next
      end
    end
  end
end
