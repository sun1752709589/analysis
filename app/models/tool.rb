class Tool

  # 数字转星期
  def self.num2week(num)
    str = "星期"
    case num
    when 0
      str += "一"
    when 1
      str += "二"
    when 2
      str += "三"
    when 3
      str += "四"
    when 4
      str += "五"
    when 5
      str += "六"
    when 6
      str += "日"
    end
    str
  end

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