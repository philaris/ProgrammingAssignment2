## functions to compute inverse of matrix with cache support

## # example to create big matrix from stackoverflow:
##
## library(MASS)
## k   <- 2000
## rho <- .3
## S       <- matrix(rep(rho, k*k), nrow=k)
## diag(S) <- 1
## dat <- mvrnorm(10000, mu=rep(0,k), Sigma=S) ### be patient!
## A <- cor(dat)
## # then, run the following:
## C <- makeCacheMatrix(A)
## cacheSolve(C)
## cacheSolve(C)


## matrix object with cache support for inverse;
## input is a matrix A;
## example use: C <- makeCacheMatrix(A)
makeCacheMatrix <- function(x = matrix()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setinv <- function(inv) m <<- inv
    getinv <- function() m
    list(set = set, get = get,
         setinv = setinv,
         getinv = getinv)

}


## compute inverse of matrix; use cache to avoid recomputation;
## input is a makeCacheMatrix object
## example use:
cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of cache object 'x'
    m <- x$getinv()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- solve(data, ...)
    x$setinv(m)
    m

}
