
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(MealPlanneR)
library(data.table)
library(MASS)

shinyServer(function(input, output,session) {
  
  output$searchRecipes<-renderUI({
    list(
      div(
        selectizeInput("searchRecipeName","Search Recipe by Name:",choices=RecipeDatabase$listRecipes()$name)
      )
    )
  })
  
  output$searchRecipes2<-renderUI({
    list(
      div(
        selectizeInput("searchRecipeName2","Search Recipe by Name:",choices=RecipeDatabase$listRecipes()$name)
      )
    )
  })
  
  output$displaySelectedRecipe<-renderUI({
    input$searchRecipeName
    if(input$searchRecipeName=="" | is.null(input$searchRecipeName)){
      warning("No Recipe Selected; therefore cannot display.")
      return(NULL)
    }
    isolate({
      recipeList<-RecipeDatabase$listRecipes()
      message(input$searchRecipeName)
      fullRecipe<-RecipeDatabase$recipes[[which(recipeList$name==input$searchRecipeName)]]
      ingredients.table<-copy(fullRecipe$ingredients)
      ingredients.table[,quantity:=paste0(as.character(fractions(quantity))," ",units),]
      ingredients.table$units<-NULL
      ingredients.table$id<-NULL
      #cat(ingredients.table)
      
      return(
        list(
            hr(),
            h4(fullRecipe$metadata$name),
            if(!is.na(fullRecipe$metadata$category)){p(fullRecipe$metadata$category)},
            p(fullRecipe$metadata$comment),
            p(strong("Ingredients:")),
            div(renderTable(ingredients.table,include.rownames=FALSE),class="ingredTable"),
            tags$head(tags$style(".ingredTable table {width:90%;}")),
            p(strong("Directions:")),
            p(fullRecipe$directions)
          ))
      
    })
  })
  
  output$addRecipeUI<-renderUI({
    return(list(
      textInput("addRecipeName",label = "Name:"),
      selectInput("addRecipeCategory",label="Category:",choices = c("Appetizer","Salad","Main","Side","Desert","Baking"),selectize = TRUE),
      textInput("addRecipeComment",label = "Comment:"),
      numericInput("addRecipeTime",label = "Estimated Time (min):",value = 15,min = 1,max=1440,step = 15),
      textInput("addRecipeGenre",label="Cusine Style:"),
      numericInput("addRecipeServings",label = "No. Servings:",value = 2,min = 1,max=36,step = 1)
      ))
  })
  
  #### Function to Add Recipe on Button Press ####
  goCreateRecipe<-reactive({
    input$buttonCreateRecipe
    isolate({
      if(input$buttonCreateRecipe>0){
        tempRecipe<-new("Recipe")
        tempRecipe$updateMetadata(name=input$addRecipeName,category=input$addRecipeCategory,comment=input$addRecipeComment,est.time=input$addRecipeTime,genre=input$addRecipeGenre,servings=input$addRecipeServings)
        return(tempRecipe)
      } else {
        return(NULL)
      }
    })
  })
  
  
  output$addIngredientsUI<-renderUI({
    tempRecipe<-goCreateRecipe()
    if(!is.null(tempRecipe)){
      return(
        list(
          wellPanel(
            p(strong("Add Ingredients:")),
            textInput("addIngredientName",label = "Name:"),
            numericInput("addIngredientQty",label = "Quantity:",value = 0),
            selectInput("addIngredientUnit",label="Unit:",choices = c("cup","tbsp","tsp","oz","lbs","ml","g","ea","knob","lug"),selectize = FALSE),
            br(),
            actionButton("buttonAddIngredient",label = "Add Ingredient"),
            actionButton("buttonResetIngredient",label = "Reset"),
            hr()
          )
        )
      )
    } else {
      return(NULL)
    }
  })
  
})
