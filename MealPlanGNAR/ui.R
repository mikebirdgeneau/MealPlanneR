
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(MealPlanneR)


shinyUI(
  navbarPage(
    title = "MealPlanGNAR",collapsable=TRUE,fluid=TRUE,responsive=TRUE,inverse=TRUE,windowTitle="MealPlanGNAR",
    tabPanel("Meal Plan",
             fluidRow(
               column(12,
                      h3("Meal Plan"),
                      hr()
               )
             )
    ),
    tabPanel("Recipe Browser",
             fluidRow(
               column(12,
                      h3("Recipe Browser"),
                      hr(),
                      uiOutput("searchRecipes")
               )
             ),
             fluidRow(
               column(12,
                      uiOutput("displaySelectedRecipe")
                      )
               )
    ),
    tabPanel("Recipe Editor",
             fluidRow(
               column(12,
                      h3("Recipe Editor"),
                      hr(),
                      tabsetPanel(id = "recipeEditor",type = "pills",position = "above",
                                  tabPanel("Add Recipe",
                                           fluidRow(
                                             column(4,
                                                    uiOutput("addRecipeUI"),
                                                    actionButton("buttonCreateRecipe",label = "Create Recipe"),
                                                    br(),
                                                    br()
                                                    ),
                                             column(8,
                                                    uiOutput("addIngredientsUI"),
                                                    uiOutput("ingredientTable"),
                                                    uiOutput("addDirections"),
                                                    uiOutput("recipeSaveButton"),
                                                    uiOutput("saveStatus")
                                             )
                                           )
                                  ),
                                  tabPanel("Edit Recipe",
                                           uiOutput("searchRecipes2"),
                                           p("Feature incomplete.")
                                           ),
                                  tabPanel("Remove Recipe",
                                           p("Feature not implemented.")
                                  )
                      )
               )
             )
    ),
    footer=fluidRow(
      column(12,
             hr(),
             p("Copyright (C) 2015 Mike Birdgeneau. All Rights Reserved.")
             )
      )
  )
)
