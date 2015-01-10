# Test Meal Plan

source("test/testRecipe.R")

testMealPlan<-new("MealPlan")

testMealPlan$addRecipe(testRecipe)

testMealPlan
