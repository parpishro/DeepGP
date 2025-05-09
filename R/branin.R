#' Branin Function
#'
#' A popular 2-dimensional test function with three global minima. The function
#' has a simple structure but with enough complexity to evaluate optimization
#' algorithms. Always evaluated in 2 dimensions with input ranges x1 ∈ [-5, 10],
#' x2 ∈ [0, 15].
#'
#' @param xx Numeric vector of 2 inputs c(x1, x2)
#' @param a Constant parameter, default is 1
#' @param b Constant parameter, default is 5.1/(4*pi^2)
#' @param c Constant parameter, default is 5/pi
#' @param r Constant parameter, default is 6
#' @param s Constant parameter, default is 10
#' @param t Constant parameter, default is 1/(8*pi)
#'
#' @return The function value at the given point
#' @export
#'
#' @note Source: http://www.sfu.ca/~ssurjano/
#'       Copyright 2013, Derek Bingham, Simon Fraser University
#'
#' @examples
#' # Evaluate at a random point
#' branin(c(runif(1, -5, 10), runif(1, 0, 15)))
#'
#' # Evaluate at one of the global minima
#' branin(c(-pi, 12.275))  # Should return 0.397887
branin <- function(
  xx,
  a = 1,
  b = 5.1 / (4 * pi^2),
  c = 5 / pi,
  r = 6,
  s = 10,
  t = 1 / (8 * pi)
) {

  x1      <- xx[1]
  x2      <- xx[2]
  term1   <- a * (x2 - b * x1^2 + c * x1 - r)^2
  term2   <- s * (1 - t) * cos(x1)
  y       <- term1 + term2 + s
  return(y)
}
