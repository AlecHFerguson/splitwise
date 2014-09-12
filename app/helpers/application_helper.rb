module ApplicationHelper
  def format_dollars(number)
    number_to_currency(number, precision: 0)
  end

  def format_dollars_cents(number)
    number_to_currency(number)
  end
end
