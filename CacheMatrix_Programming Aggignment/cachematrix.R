## Put comments here that give an overall description of what your
## functions do

## This function creates a list of 4 functions to set and get values of matrix and inverse matrix

makeCacheMatrix <- function(x, ...){
  inverse_matrix<-NULL
  set<-function(y){
    x<<-y
    inverse_matrix<<-NULL
  }
  set_inverse<-function(i){
    inverse_matrix<-i
  }
  get<-function(){
    x
  }
  get_inverse<-function(){
    inverse_matrix
  }
  return(list(set=set,get=get,set_inverse=set_inverse,get_inverse=get_inverse))
}

## This function gives the inverse matrix from cache if possible, else calculates it

cacheSolve<-function(x, ...){
  inverse_matrix<-x$get_inverse()
  if(!is.null(inverse_matrix)){
    return(inverse_matrix)
  }
  data<-x$get()
  inverse_matrix<-solve(data, ...)
  x$set_inverse(inverse_matrix)
  inverse_matrix
}

