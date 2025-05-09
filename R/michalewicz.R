#' Michalewicz Function
#'
#' A multimodal test function with steep ridges and valleys. The function has
#' d! local minima, where d is the dimension. The steepness of the valleys and
#' ridges is controlled by the parameter m. Typically evaluated in 2-10
#' dimensions with input range [0, π] for all dimensions.
#'
#' @param xx Numeric vector of inputs c(x1, x2, ..., xd)
#' @param m  Steepness parameter (default = 10), larger values create steeper
#'           valleys
#'
#' @return The function value at the given point
#' @export
#'
#' @note Source: http://www.sfu.ca/~ssurjano/
#'       Copyright 2013, Derek Bingham, Simon Fraser University
#'
#' @examples
#' # Evaluate in 2D
#' michalewicz(c(2.2, 1.57))
#'
#' # Evaluate in 5D with default steepness
#' michalewicz(runif(5, 0, pi))
#'
#' # Evaluate with higher steepness parameter
#' michalewicz(c(2.2, 1.57), m = 20)
michalewicz <- function(xx, m = 10) {

  ii      <- c(1:seq_along(xx))
  sum     <- sum(sin(xx) * (sin(ii * xx^2 / pi))^(2 * m))
  y       <- -sum
  return(y)
}
