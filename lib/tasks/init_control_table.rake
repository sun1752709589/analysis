# encoding: utf-8
namespace :data do
  desc "init vanke bulb house control table"
  task :init_vanke_bulb_house_table do
    Rake::Task[:environment].invoke
    path = `pwd`.strip + "/lib/tasks/data/vanke_*_house_table.txt"
    Dir.glob(path).each do |file_path|
      device_type = file_path.split('_')[1]
      IO.foreach(file_path) do |line|
        tmp = line.split(' ')
        VankeDeviceHouseTable.create({device_id: tmp[1], device_type: device_type, house_id: tmp[0]})
      end
    end
    puts "---init success---"
  end
end