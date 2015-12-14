class Tool

  # 秒转小时
  def self.second2hour(second)
    return 0 if second.nil?
    if second < 60
      "#{second}秒"
    elsif second < 3600
      "#{(second.to_f/60).round(2)}分钟"
    elsif second < 86400
      "#{(second.to_f/3600).round(2)}小时"
    end
  end

  # 找到所有符合要求的日志文件
  def self.find_files(base_path, pattern, start_time, end_time)
    return [] if base_path.nil? || pattern.nil? || start_time.nil? || end_time.nil?
    start_date = Date.parse(start_time)
    end_date = Date.parse(end_time)
    files = []
    Dir.glob(base_path + "/#{pattern}").each do |item|
      date_str = item.split('/')[-1].split('.')[-1]
      date_time = Date.parse(date_str)
      files << item if date_time >= start_date && date_time <= end_date
    end
    files
  end
end