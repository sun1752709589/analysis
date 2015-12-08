class Tool

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

end