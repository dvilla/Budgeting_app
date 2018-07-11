require_relative 'test_helper'

describe 'Budget test' do
  include BudgetList

  before do
    visit('/')
  end

  it 'Adds an income to the budget and check element appears in the list, and that balance is correct' do
    select_element_category("Income")
    fill_in_description("We did very good this month")
    fill_in_amount(7400)
    submit_element

    #calculating the sum incomes and the sum of outcomes from the list
    sum_of_incomes_from_list = get_all_incomes_amounts.reduce(:+)
    sum_of_outcomes_from_list = get_all_outcomes_amounts.reduce(:+)

    assert_equal "We did very good this month", description_of_last_element_added_to_budget
    assert_equal "$7,400.00", amount_of_last_element_added_to_budget
    assert_equal "Income", category_of_last_element_added_to_budget

    assert_equal total_inflow, sum_of_incomes_from_list
    assert_equal total_outflow, sum_of_outcomes_from_list.abs

    #We sum the outcomes since those are negative
    calculated_working_balance = sum_of_incomes_from_list + sum_of_outcomes_from_list
    assert_equal calculated_working_balance, working_balance
  end

  it 'Adds an outflow element to budget and check balance is correct' do
  end

  it 'Adds a new element to budget and checks it is refleced on the reports' do
  end

  after do
  end

end


