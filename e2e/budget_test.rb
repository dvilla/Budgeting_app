require_relative 'test_helper'

describe 'Budget test' do
  include BudgetListPageObject
  include BudgetReportsPageObject

  before do
    visit('/')
  end

  it 'Adds an income to the budget and checks element appears in the list, and that balance is correct' do
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

  it 'Adds an outflow element to budget to create a negative balance, and checks balance is correct' do
    select_element_category("taxes")
    fill_in_description("It's that time of the year again")
    fill_in_amount(10400)
    submit_element

    #calculating the sum incomes and the sum of outcomes from the list
    sum_of_incomes_from_list = get_all_incomes_amounts.reduce(:+)
    sum_of_outcomes_from_list = get_all_outcomes_amounts.reduce(:+)

    assert_equal "It's that time of the year again", description_of_last_element_added_to_budget
    assert_equal "-$10,400.00", amount_of_last_element_added_to_budget
    assert_equal "Taxes", category_of_last_element_added_to_budget

    assert_equal total_inflow, sum_of_incomes_from_list
    assert_equal total_outflow, sum_of_outcomes_from_list.abs

    #We sum the outcomes since those are negative
    calculated_working_balance = sum_of_incomes_from_list + sum_of_outcomes_from_list
    assert_equal calculated_working_balance, working_balance, "\n\e[31m#{'Working balance does not equals the sum of all outflows, please check sums and signs are correct'}\e[0m"
  end

  it 'Adds a outflow and inflow element to budget and checks it is refleced on the reports' do
    select_element_category("taxes")
    fill_in_description("It's that time of the year again")
    fill_in_amount(10400)
    submit_element

    select_element_category("income")
    fill_in_description("It's that time of the year again")
    fill_in_amount(11400)
    submit_element

    total_inflow_on_budget_page = total_inflow
    total_outflow_on_budget_page = total_outflow

    go_to_reports_page
    
    assert page.has_content? "$#{number_with_delimiter(total_inflow_on_budget_page)}"
    assert page.has_content? "$#{number_with_delimiter(total_outflow_on_budget_page)}"
    assert page.has_content? /taxes/i
    assert page.has_content? "$10,400.00"

    go_to_spending_by_category
    assert page.has_content? "$10,400.00"
  end

end


