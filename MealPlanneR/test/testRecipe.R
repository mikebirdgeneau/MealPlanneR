# Test Recipe Generation

testRecipe<-new("Recipe")

testRecipe$updateMetadata(name="Test Recipe")

testRecipe$addIngredient("Flour",1,"cup")
testRecipe$addIngredient("Water",2,"cup")


testRecipe$addDirections("Start by preheating oven to 400F")
testRecipe$addDirections("Mix Flour and Water in a small bowl.")


testRecipe
