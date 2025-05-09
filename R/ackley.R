#' Ackley Function
#'
#' A multimodal test function with many local minima, commonly used for testing
#' optimization algorithms. The function has a global minimum at the origin.
#' Typically evaluated in 2-10 dimensions with input range [-32.768, 32.768]
#' for all dimensions.
#'
#' @param xx Numeric vector of inputs c(x1, x2, ..., xd)
#' @param a Constant parameter, default is 20
#' @param b Constant parameter, default is 0.2
#' @param c Constant parameter, default is 2*pi
#'
#' @return The function value at the given point
#' @export
#'
#' @note Source: http://www.sfu.ca/~ssurjano/
#'       Copyright 2013, Derek Bingham, Simon Fraser University
#'
#' @examples
#' ackley(c(0, 0))  # Evaluates to approximately 0 (global minimum)
#' ackley(runif(5, -32.768, 32.768))  # Random 5D point
ackley <- function(xx, a = 20, b = 0.2, c = 2 * pi) {
  d      <- length(xx)
  sum1   <- sum(xx^2)
  sum2   <- sum(cos(c * xx))

  term1  <- -a * exp(-b * sqrt(sum1 / d))
  term2  <- -exp(sum2 / d)

  y      <- term1 + term2 + a + exp(1)
  return(y)
}
