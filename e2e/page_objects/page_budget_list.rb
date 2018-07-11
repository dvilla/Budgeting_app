module BudgetList

  def select_element_category(category)
    find("[name='categoryId']").find(:option, text: /#{category}/i).click
  end

  def fill_in_description(description)
    find("[name='description']").set(description)
  end

  def fill_in_amount(amount)
    find("[name='value']").set(amount)
  end

  def submit_element
    find("[type='submit']").click
  end

  def last_row_added_to_budget
    find('.containers-BudgetGrid-style-budgetGrid').all('tr')[-2]
  end

  def amount_of_last_element_added_to_budget
    last_row_added_to_budget.all('td').last.text
  end

  def description_of_last_element_added_to_budget
    last_row_added_to_budget.all('td')[1].text
  end
  
  def category_of_last_element_added_to_budget
    last_row_added_to_budget.all('td').first.text
  end

  def total_inflow
    all('.components-Balance-style-balanceAmount')[0].text.tr("$,","").to_f
  end

  def total_outflow
    all('.components-Balance-style-balanceAmount')[1].text.tr("$,","").to_f
  end

  def working_balance
    all('.components-Balance-style-balanceAmount')[2].text.tr("$,","").to_f
  end

  def get_all_incomes_amounts
    find('tbody').all('tr', text: /income/i).map do |row|
      row.text.match(/(-?)\$\d.*$/)[0].tr("$,","").to_f
    end
  end

  def get_all_outcomes_amounts
    find('tbody').all('tr', text: /^(?!income).*/i).map do |row|
      row.text.match(/(-?)\$\d.*$/)[0].tr("$,","").to_f
    end
  end

end