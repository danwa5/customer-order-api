class FetchProductSales
  def initialize(start_date: start_date, end_date: end_date, unit: unit)
    @start_date = format_date(start_date)
    @end_date = format_date(end_date)
    @unit = String(unit).downcase
  end

  def call
    ActiveRecord::Base.connection.exec_query(query)
  end

  private

  def format_date(date_str)
    Date.parse(date_str).strftime('%Y-%m-%d')
  end

  def date_field
    case @unit
    when 'day'
      "DATE(o.order_date) as date_part"
    when 'week'
      "DATE_PART('week', o.order_date) as date_part"
    when 'month'
      "DATE_PART('month', o.order_date) as date_part"
    else
      "DATE(o.order_date) as date_part"
    end
  end

  def query
    "select p.id as product_id, p.name as product_name, #{date_field}, SUM(ol.quantity) as total_quantity " \
    "from products p " \
    "join order_lines ol on p.id = ol.product_id " \
    "join orders o on o.id = ol.order_id " \
    "where o.order_date between '#{@start_date}' and '#{@end_date}' " \
    "group by p.id, date_part " \
    "order by p.name, date_part;"
  end
end
