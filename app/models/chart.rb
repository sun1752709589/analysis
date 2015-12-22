require 'axlsx'
examples = []
examples << :basic
examples << :custom_styles
examples << :wrap_text
examples << :cell_style_override
examples << :custom_borders
examples << :surrounding_border
examples << :deep_custom_borders
examples << :row_column_style
examples << :fixed_column_width
examples << :height
examples << :outline_level
examples << :merge_cells
examples << :images
examples << :format_dates
examples << :mbcs
examples << :formula
examples << :auto_filter
examples << :data_types
examples << :override_data_types
examples << :hyperlinks
examples << :number_currency_format
examples << :venezuela_currency
examples << :bar_chart
examples << :chart_gridlines
examples << :pie_chart
examples << :line_chart
examples << :scatter_chart
examples << :tables
examples << :fit_to_page
examples << :hide_gridlines
examples << :repeated_header
examples << :defined_name
examples << :printing
examples << :header_footer
examples << :comments
examples << :panes
examples << :book_view
examples << :sheet_view
examples << :hiding_sheets
examples << :conditional_formatting
examples << :streaming
examples << :shared_strings
examples << :no_autowidth
examples << :cached_formula
examples << :page_breaks
examples << :rich_text
examples << :tab_color
p = Axlsx::Package.new
wb = p.workbook
if examples.include? :tables
  wb.add_worksheet(:name => "Table") do |sheet|
    sheet.add_row ["Build Matrix"]
    sheet.add_row ["Build", "Duration", "Finished", "Rvm"]
    sheet.add_row ["19.1", "1 min 32 sec", "about 10 hours ago", "1.8.7"]
    sheet.add_row ["19.2", "1 min 28 sec", "about 10 hours ago", "1.9.2"]
    sheet.add_row ["19.3", "1 min 35 sec", "about 10 hours ago", "1.9.3"]
    sheet.add_table "A2:D5", :name => 'Build Matrix', :style_info => { :name => "TableStyleMedium23" }
  end
end
p.use_shared_strings = true
p.serialize('simple.xlsx')