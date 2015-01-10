# Test Meal Plan
library(MealPlanneR)

source("../MealPlanneR/test/testRecipe.R")

RecipeDatabase<-new("RecipeDB")

RecipeDatabase$addRecipe(testRecipe$copy())
testRecipe$updateMetadata(name="Test Recipe 2")
RecipeDatabase$addRecipe(testRecipe$copy())

RecipeDatabase$listRecipes()

RecipeDatabase$saveDB(file="recipeDB.rda")

