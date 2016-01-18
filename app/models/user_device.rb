class UserDevice < ActiveRecord::Base

  DeviceTypeWords = {
      'router' => '路由',
      'bulb' => '灯泡',
      'nova2' => 'Nova2',
      'door_sensor' => '门磁',
      'infrared_sensor' => '红外传感器',
      'switch' => '随心开关',
      'sensors' => '环境控制器',
      'th_sensor' => '环境控制器',
      'air_quality_sensor' => '环境控制器',
      'ac_controller' => '环境控制器',
      'wall_switch_single' => '单路墙面开关',
      'wall_switch_double' => '双路墙面开关',
      'wall_switch_triple' => '三路墙面开关',
      'wall_switch_single_f0' => '单路墙面火零开关',
      'wall_switch_double_f0' => '双路墙面火零开关',
      'wall_switch_triple_f0' => '三路墙面火零开关',
      'wall_switch_pro_single_f0' => '单路PIXELPro',
      'wall_switch_pro_double_f0' => '双路PIXELPro',
      'wall_switch_pro_triple_f0' => '三路PIXELPro',
      'wall_switch_lite_single_f0' => '单路PIXELLite',
      'wall_switch_lite_double_f0' => '双路PIXELLite',
      'wall_switch_lite_triple_f0' => '三路PIXELLite',
      'yap' => '亚都空气净化机',
      'generic_module' => '通用模块',
      'door_access' => '门禁',
      'vanke_eco_tower' => '万科EcoTower'
  }

  DeviceTypeMaps = {
    'router' => '网关',
    'nova2|bulb' => 'Nova灯',
    'switch' => '随心开关',
    'wall_switch' => '墙面开关',
    'door_sensor' => '门磁'
  }

  def fetch
    User.all.each do |user|
      UserDevice.create({device_types: user.devices.map(&:device_type).join(','),user_id: user.id})
    end
  end

  def self.user_device_overview
    result = {}
    arr = ['router', 'nova2|bulb', 'switch', 'wall_switch', 'door_sensor']
    arr_hash = {}
    (1..arr.size).each do |i|
      tmp = arr.combination(i).to_a
      tmp.each do |item|
        arr_hash[item] = item
      end
    end
    arr_hash = arr_hash.sort_by{|k,v| 10-v.size}
    arr_hash.each do |item|
      result[item[0]] = []
    end
    UserDevice.all.each do |item|
      next if item.device_types.nil? || item.device_types.size < 5
      arr_hash.each do |types|
        contain = device_type_contains?(item.device_types, types[1])
        if contain
          result[types[0]] << item.user_id
          break
        end
      end
    end
    result
  end

  def self.device_type_contains?(devcie_types, types)
    contain = true
    device_types_arr = devcie_types.split(',')
    types.each do |item|
      if 'wall_switch' == item
        contain = devcie_types.include?(item)
      elsif item.include?('|')
        sun = item.split('|')
        contain = (devcie_types.include?(sun[0]) || devcie_types.include?(sun[1]))
      else
        contain = device_types_arr.include?(item)
      end
      return false unless contain
    end
    contain
  end

  def self.user_device_sum(device_type)
    result = {}
    if 'nova2|bulb' == device_type
      UserDevice.all.each do |item|
        sum = item.device_types.split(',').select{|x| (x == 'nova2' || x == 'bulb')}.size
        result[sum] = [] if result[sum].nil?
        result[sum] << item.user_id
      end
    elsif 'wall_switch' == device_type
      UserDevice.all.each do |item|
        sum = item.device_types.split(',').select{|x| x.include?('wall_switch')}.size
        result[sum] = [] if result[sum].nil?
        result[sum] << item.user_id
      end
    else
      UserDevice.all.each do |item|
        sum = item.device_types.split(',').select{|x| x.include?(device_type)}.size
        result[sum] = [] if result[sum].nil?
        result[sum] << item.user_id
      end
    end
    result.sort.to_h
  end

  def self.only_has_router_users
    result = []
    UserDevice.all.each do |item|
      result << User.find(item.user_id) if item.device_types.split(',').uniq == ['router']
    end
    result
  end
  def self.not_has_router_users
    result = []
    UserDevice.all.each do |item|
      next if item.device_types.size < 5 || item.device_types.split(',').size < 1
      result << User.find(item.user_id) unless item.device_types.split(',').include?('router')
    end
    result
  end
end