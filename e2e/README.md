## Pre-requisits

* Install chrome browser and latest version of chromedriver http://chromedriver.storage.googleapis.com/index.html?path=2.40/
on your system
* Install version 2.3.5 of ruby, I recommend using rvm https://rvm.io/

# Test plan

### TABLE OF CONTENTS

1. Introduction 
2. Scope of the app
3. Test strategy:
4. Integration testing
5. Test cases
6. How to execute


### INTRODUCTION

This test plan will focus on the integration side and how the app is tested in that realm, no unit or security tests will be described here. The app small, as it was only intended to keep track of a budget, doing sums and rest of incomes and outcomes. The app also counts with a graphic side, provided by a javascript library called D3.

### SCOPE OF THE APP

The app core feature is the tracking of a budget. It has one simple functionality that the user can do, adding new elements to the list, currently there’s no way to remove or edit the list. Another thing is seeing the charts on the reports page/route which needs to functional testing.

User then can add two types of elements to the list, incomes and outcomes, incomes are defined by the category income, everything else is an outcome therefore a subtraction to the balance
	
User can:
Add an income element to the budget
Add outcome element to the budget
See 2 types of graphics on the reports page


### TEST STRATEGY

As mentioned above this test plan will be based on the integration tests, non unit, load or security testing will be applied on this plan

Integration testing

Things that are verified on the integration plan:

User can add new element to the budget list
The sum of all the incomes in the list is the total inflow
The sum of all the other 

### TEST CASES

A full list of test cases will be impossible as full would imply test out of the scope of this plan but we will try to cover the most valuable ones, the ones that touch the core centric feature of the app

All test cases are considered to start from the root of the app. The following link will provide a spreadsheet with test cases

| Description                                                                                                      | Input data                                              | Expected behaviour                                                                                                                                    |
|------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------|
| User adds income to the buget list                                                                               | category: "income", description: "income", amount: 3400 | New element appears on the budget list. Income is summed to Total Inflow, Total outflow is abstracted from Total inflow and result is Working balance |
| User adds outcome (any element except income) on the category                                                    | category: "taxes", description: "taxes", amount: 5200   | New element appears on the budget list. Income is summed to Total Inflow, Total outflow is abstracted from Total inflow and result is Working balance |
| User adds income to the buget list without description                                                           | category: "income", description: "", amount: 3400       | Income is summed to Total Inflow, Total outflow is abstracted from Total inflow and result is Working balance                                         |
| User adds outcome (any element except income) on the category without description                                | category: "taxes", description: "", amount: 5200        | Income is summed to Total Inflow, Total outflow is abstracted from Total inflow and result is Working balance                                         |
| User adds a string as value for the amount                                                                       | category: "taxes", description: "", amount: "amount"    | No strings will be entered on the amount input, also 'add' button sill stay grayed out                                                                |
| User sees 'Inflow vs outflow chart' by clicking on reports navigation button                                     | -                                                       | Chart will be displaying showing the inflow and the outlfow in a bar type                                                                             |
| User sees 'Spending by category chart' by clicking on 'reports' navigation button then on 'spending by category' | -                                                       | A donut chart will be displaying showing the outflows                                                                                                 |


### HOW TO EXECUTE

Before running integration tests install all dependencies by running the next command on the project dir

```npm run test:prepare-integration```

Integration tests are executed by running 

```npm run test:integration```

 and if you want to have an HTML reporter run

 ```test:integration-html-report```

### GOOGLE DOC VERSIONS

Test cases:

https://docs.google.com/spreadsheets/d/1EJvfesTiDMEMPKxN5kzngwJNM9UVImmi7bvPRUZXzXw/edit#gid=0

Budget plan:

https://docs.google.com/document/d/16bInwP5DNatb2ii5qCO5eJZFmTrOWrCto2GS-uCZ6h0/edit