require 'axlsx'
examples = []
examples << :pie_chart
examples << :scatter_chart
examples << :line_chart
p = Axlsx::Package.new
wb = p.workbook
if examples.include? :pie_chart
  wb.add_worksheet(:name => "Pie Chart") do |sheet|
    sheet.add_row ["Simple Pie Chart"]
    %w(first second third).each { |label| sheet.add_row [label, rand(24)+1] }
    sheet.add_chart(Axlsx::Pie3DChart, :start_at => [0,5], :end_at => [10, 20], :title => "example 3: Pie Chart") do |chart|
      chart.add_series :data => sheet["B2:B4"], :labels => sheet["A2:A4"],  :colors => ['FF0000', '00FF00', '0000FF']
    end
  end
end
if examples.include? :scatter_chart
  wb.add_worksheet(:name => "Scatter Chart") do |sheet|
    sheet.add_row ["First",  1,  5,  7,  9]
    sheet.add_row ["",       1, 25, 49, 81]
    sheet.add_row ["Second", 5,  2, 14,  9]
    sheet.add_row ["",       5, 10, 15, 20]
    sheet.add_chart(Axlsx::ScatterChart, :title => "example 7: Scatter Chart") do |chart|
      chart.start_at 0, 4
      chart.end_at 10, 19
      chart.add_series :xData => sheet["B1:E1"], :yData => sheet["B2:E2"], :title => sheet["A1"], :color => "FF0000"
      chart.add_series :xData => sheet["B3:E3"], :yData => sheet["B4:E4"], :title => sheet["A3"], :color => "00FF00"
    end
  end
end
if examples.include? :line_chart
  wb.add_worksheet(:name => "Line Chart") do |sheet|
    sheet.add_row ["Simple Line Chart"]
    sheet.add_row %w(first second)
    4.times do
      sheet.add_row [ rand(24)+1, rand(24)+1]
    end
    sheet.add_chart(Axlsx::Line3DChart, :title => "Simple 3D Line Chart", :rotX => 30, :rotY => 20) do |chart|
      chart.start_at 0, 5
      chart.end_at 10, 20
      chart.add_series :data => sheet["A3:A6"], :title => sheet["A2"], :color => "0000FF"
      chart.add_series :data => sheet["B3:B6"], :title => sheet["B2"], :color => "FF0000"
      chart.catAxis.title = 'X Axis'
      chart.valAxis.title = 'Y Axis'
    end
    sheet.add_chart(Axlsx::LineChart, :title => "Simple Line Chart", :rotX => 30, :rotY => 20) do |chart|
      chart.start_at 0, 21
      chart.end_at 10, 41
      chart.add_series :data => sheet["A3:A6"], :title => sheet["A2"], :color => "FF0000"
      chart.add_series :data => sheet["B3:B6"], :title => sheet["B2"], :color => "00FF00"
      chart.catAxis.title = 'X Axis'
      chart.valAxis.title = 'Y Axis'
    end

  end
end

p.use_shared_strings = true
p.serialize('simple.xlsx')