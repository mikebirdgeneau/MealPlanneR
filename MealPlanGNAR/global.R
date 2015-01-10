library(MealPlanneR)

if(!file.exists("recipeDB.rda"))
{
  RecipeDatabase<-new("RecipeDB")
} else {
  load("recipeDB.rda")
}
