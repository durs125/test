mat <- matrix( c(1,2,3,4),2,2)## Put comments here that give an overall description of what your
## functions do

## This function returns a list object with functions associated with it. 
##These functions allow the inverse to be stored

makeCacheMatrix <- function(x= matrix()) {
        xm<-x
        
        mm <- NULL
        set2 <- function(ym) {
                xm <<- ym
                mm <<- NULL
        }
        get2 <<- function() xm
        setinverse <- function(inversed) mm <<- inversed
        getinverse <- function() mm
        list(set = set2, get = get2,
             setinverse = setinverse,
             getinverse = getinverse)
}


## This function computes the inverse of a matrix that has been processed by
##makeCacheMatrix. Lets you know if the inverse has been computed before

cacheSolve <- function(x, ...) {
        xm<-x
        mm <- xm$getinverse()
        
        if(!is.null(mm)) {
                message("getting cached data")
                return(mm)
        }
        data <- xm$get()
        mm <- solve(data, ...)
        xm$setinverse(mm)
        mm

              ##  Return a matrix that is the inverse of 'x'
}
