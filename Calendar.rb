require 'date'
require 'colorize'
require_relative 'Events'
class Calendar
  extend Event
  @instance = new

  private_class_method :new
  def self.instance
    @instance
  end

  def self.display_calender
    @date = Date.today
    @days_of_week = Date::DAYNAMES.map { |x| " #{x}" }
    @month_name = Date::MONTHNAMES[@date.month]
    tmp_date = Date.new(@date.year, @date.month)

    calendar_header
    calendar_body(tmp_date)
    return true
  end

  def self.calendar_header
    year_month_str = "#{@date.year} - #{@month_name}"
    line_length = @days_of_week.join.length
    padding = line_length / 2 - year_month_str.length / 2
    puts '-' * line_length
    puts year_month_str.rjust(year_month_str.length + padding, ' ')
    puts @days_of_week.join
  end

  def self.calculate_padding(curr_week_day)
    prev_days = @days_of_week.collect { |day| day if @days_of_week.index(day) < curr_week_day }
    ''.ljust(prev_days.join.size, ' ')
  end

  def self.calculate_event_length(no_of_events)
    event_length = no_of_events.digits.count + 2
    event_length = 0 if no_of_events.zero?
    event_length
  end

  def self.display_cell(tmp_date, cell_length, prev_padding)
    no_of_events = event_count(tmp_date)
    event_length = calculate_event_length(no_of_events)
    day_str = tmp_date.day.to_s.rjust(cell_length - event_length.to_i, ' ')
    cell = "#{prev_padding}#{day_str}"
    cell = "#{cell}\(#{no_of_events}\)".blue unless no_of_events.zero?
    cell = cell.yellow if tmp_date.day == @date.day
    print cell
  end

  def self.calendar_body(tmp_date)
    curr_week_day = tmp_date.wday
    curr_month = tmp_date.month
    prev_padding = calculate_padding(curr_week_day)
    while tmp_date.month == curr_month
      while curr_week_day < @days_of_week.length && tmp_date.month == curr_month
        cell_length = @days_of_week[tmp_date.wday].length
        display_cell(tmp_date, cell_length, prev_padding)
        prev_padding = ''
        tmp_date += 1
        curr_week_day += 1
      end
      curr_week_day = 0
      puts
    end
  end
end
