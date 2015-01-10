## MealPlan Object

#' MealPlan Object
#' @exportClass
#' 
MealPlan<-setRefClass("MealPlan",fields = c(metadata="list",
  recipes="list"),
methods=list(
    initialize=function(...){
      .self$recipes<-list()
      .self$metadata<-list(name=NA,date=Sys.Date())
      .self$metadata$name<-paste0("Meal Plan for ",.self$metadata$date)
    },
    addRecipe=function(recipe.obj){
      num.recipes<-length(.self$recipes)+1
      .self$recipes[[num.recipes]]<-recipe.obj
    },
    removeRecipe=function(i){
      .self$recipes[[i]]<-NULL
    }
  )
)




