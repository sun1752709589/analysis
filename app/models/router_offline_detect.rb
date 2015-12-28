Status = [
    [:unknown, '未知'], # 0
    [:online, '在线'], # 1
    [:offline, '离线'], # 2
    [:violence_closed, '由于暴力关闭而离线'], # 3
    [:no_router, '没有网关'], # 4
    [:router_offline, '有网关，但是网关不在线'], # 5
    [:never_online, '从未上线'] # 6
]

MAX = 10000000
(0..MAX).each do |i|
  conn = DeviceConnectivity.find(563).try(:connectivity)
  puts conn == 1 ? "在线--#{Time.now.to_s}--#{conn}" : "离线--#{Time.now.to_s}--#{conn}"
  sleep 1
end

# send rb to router
di = DeviceInfo.find_by_device_ip 2258
cmd = Command.new :rb
NodeServer.send_cmd!(2258,cmd)
