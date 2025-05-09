#' Rosenbrock Function
#'
#' A classic optimization test function also known as the Valley or Banana
#' function. It features a narrow, curved valley with the global minimum inside
#' the valley. The function has strong parameter dependencies, making it
#' challenging for many optimization algorithms. Typically evaluated in 2-20
#' dimensions with input range [-5, 10] for all dimensions.
#'
#' @param xx Numeric vector of inputs c(x1, x2, ..., xd)
#'
#' @return The function value at the given point
#' @export
#'
#' @note Source: http://www.sfu.ca/~ssurjano/
#'       Copyright 2013, Derek Bingham, Simon Fraser University
#'
#' @examples
#' # Evaluate at the global minimum
#' rosenbrock(rep(1, 5))  # Should return 0
#'
#' # Evaluate at a random point in 4D
#' rosenbrock(runif(4, -5, 10))
rosenbrock <- function(xx) {

  d       <- length(xx)
  xi      <- xx[1:(d - 1)]
  xnext   <- xx[2:d]
  sum     <- sum(100 * (xnext - xi^2)^2 + (xi - 1)^2)
  y       <- sum
  return(y)
}
