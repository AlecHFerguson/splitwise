module ApplicationHelper
  def format_dollars(number)
    number_to_currency(number, precision: 0)
  end

  def format_dollars_cents(number)
    number_to_currency(number)
  end

  # Populates the @tabs attribute with all tabs owned by the current user
  def get_all_tabs
    @tabs = Tab.where(user_id: current_user.id)
  end

end
