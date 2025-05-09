#' Currin et al. (1988) Exponential Function
#'
#' A 2-dimensional test function commonly used for optimization and machine
#' learning problems. The function is characterized by strong nonlinearity
#' and interaction between its variables.
#'
#' @param xx Numeric vector of 2 inputs c(x1, x2)
#'          x1 in [0, 1]
#'          x2 in [0, 1]
#'
#' @return The function value at the given point
#' @export
#'
#' @note Source: http://www.sfu.ca/~ssurjano/
#'       Copyright 2013, Derek Bingham, Simon Fraser University
#'
#' @examples
#' # Evaluate at a random point
#' curretal88exp(runif(2))
curretal88exp <- function(xx) {

  x1 <- xx[1]
  x2 <- xx[2]

  fact1 <- 1 - exp(-1 / (2 * x2))
  fact2 <- 2300 * x1^3 + 1900 * x1^2 + 2092 * x1 + 60
  fact3 <- 100 * x1^3 + 500 * x1^2 + 4 * x1 + 20

  # Return y
  fact1 * fact2 / fact3
}
