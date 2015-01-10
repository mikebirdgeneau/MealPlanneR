## Recipe Object

#' Recipe Object
#' @exportClass
#' 
RecipeDB<-setRefClass("RecipeDB",fields = c(
  recipes="list"),
  methods=list(
    initialize=function(...){
      .self$recipes<-list()
    },
    addRecipe=function(recipeObj){
      newID<-length(.self$recipes)+1
      .self$recipes[[newID]]<-recipeObj$copy()
    },
    updateRecipe=function(id,recipeObj){
      .self$recipes[[id]]<-recipeObj$copy()
    },
    deleteRecipe=function(id){
      .self$recipes[[id]]<-NULL
    },
    saveDB=function(file){
      RecipeDatabase<-.self$copy()
      save(RecipeDatabase,file=file)
    },
    listRecipes=function(){
      result<-rbindlist(lapply(.self$recipes,FUN = function(x){
        data.table(name=x$metadata$name,category=x$metadata$category)
      }))
      result
    }
  )
)




