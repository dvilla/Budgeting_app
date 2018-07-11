module BudgetReportsPageObject
  
  def go_to_spending_by_category
    find("[href='/reports/spending']").click
  end

  def go_to_budget_page
    find("[href='/budget']").click
  end

end