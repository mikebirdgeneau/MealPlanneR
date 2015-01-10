## Recipe Object

#' Recipe Object
#' @exportClass
#' 
Recipe<-setRefClass("Recipe",fields = c(
  metadata="list",
  ingredients="data.table",
  directions="list"),
  methods=list(
    initialize=function(...){
      .self$metadata<-list()
      .self$ingredients<-data.table()
      .self$directions<-list()
    },
    updateMetadata=function(name=NA,category=NA,comment=NA,est.time=NA,genre=NA,servings=NA,id=NA){
      if(!is.na(name)){.self$metadata$name<-name} else { stop("Recipe name must be provided.")}
      if(!is.na(category)){.self$metadata$category<-category} else {.self$metadata$category<-category}
      if(!is.na(comment)){.self$metadata$comment<-comment} else {.self$metadata$comment<-comment}
      if(!is.na(est.time)){.self$metadata$est.time<-est.time} else {.self$metadata$est.time<-est.time}
      if(!is.na(genre)){.self$metadata$genre<-genre} else {.self$metadata$genre<-genre}
      if(!is.na(servings)){.self$metadata$servings<-servings} else {.self$metadata$servings<-servings}
      if(!is.na(id)){.self$metadata$id<-id} else {.self$metadata$id<-id}
    },
    addIngredient=function(name,quantity,units){
      .self$ingredients<-data.table(rbindlist(list(.self$ingredients,data.table(id=nrow(.self$ingredients)+1,name=name,quantity=quantity,units=units))))
      .self$ingredients[,id:=seq(1,.N,by=1),]
    },
    removeIngredient=function(rem.id){
      .self$ingredients<-.self$ingredients[id!=rem.id,]
    },
    addDirections=function(directions,append=TRUE){
      if(append){
      .self$directions<-c(.self$directions,directions)
      } else {
      .self$directions<-directions
      }
    }
  )
)




