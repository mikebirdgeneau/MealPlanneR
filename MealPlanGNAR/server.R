
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
      div(style="height:150px;",
          selectizeInput("searchRecipeName","Search Recipe by Name",choices=RecipeDatabase$listRecipes()$name)
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
  
})
