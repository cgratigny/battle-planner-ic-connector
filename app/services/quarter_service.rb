class QuarterService < ApplicationService

  attr_accessor :date

  def current_quarter
    self.date = Date.today
    quarter_string
  end

  def quarter_string
    "Q#{quarter}#{date.year}"
  end

  def quarter
    (date.beginning_of_quarter.month - 1 )/ 3 + 1
  end

  def days_since_quarter_start
    ((date - date.beginning_of_quarter) / 1.day).days.to_i
  end


end
