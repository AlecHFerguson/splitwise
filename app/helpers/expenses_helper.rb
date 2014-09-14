module ExpensesHelper
  C_USER_ID     = :user_id
  C_NAME        = :name
  C_AMOUNT      = :amount
  C_DESCRIPTION = :description
  C_TAB_ID      = :tab_id

  def tab_select_list_array
    tabs_array = []
    @tabs.each do |tab|
      tabs_array.push [tab.name, tab.id]
    end
    options_for_select(tabs_array)
  end
end
