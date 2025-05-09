#' Hartmann-6 Function
#'
#' A 6-dimensional function with multiple local minima, commonly used for
#' testing optimization algorithms. The function has a global minimum of
#' approximately -3.32 at
#' (0.20169, 0.150011, 0.476874, 0.275332, 0.311652, 0.6573).
#' Always evaluated in 6 dimensions with input range [0, 1] for all dimensions.
#'
#' @param xx Numeric vector of 6 inputs c(x1, x2, x3, x4, x5, x6)
#'
#' @return The function value at the given point
#' @export
#'
#' @note Source: http://www.sfu.ca/~ssurjano/
#'       Copyright 2013, Derek Bingham, Simon Fraser University
#'
#' @examples
#' # Evaluate at a random point
#' hart6(runif(6))
#'
#' # Evaluate near the global minimum
#' hart6(c(0.20169, 0.150011, 0.476874, 0.275332, 0.311652, 0.6573))
hart6 <- function(xx) {

  alpha     <- c(1.0, 1.2, 3.0, 3.2)
  a         <- c(
    10, 3, 17, 3.5, 1.7, 8,
    0.05, 10, 17, 0.1, 8, 14,
    3, 3.5, 1.7, 10, 17, 8,
    17, 8, 0.05, 10, 0.1, 14
  )
  a_mat     <- matrix(a, 4, 6, byrow = TRUE)
  p         <- 10^(-4) * c(
    1312, 1696, 5569, 124, 8283, 5886,
    2329, 4135, 8307, 3736, 1004, 9991,
    2348, 1451, 3522, 2883, 3047, 6650,
    4047, 8828, 8732, 5743, 1091, 381
  )
  p_mat     <- matrix(p, 4, 6, byrow = TRUE)

  x_mat     <- matrix(rep(xx, times = 4), 4, 6, byrow = TRUE)
  inner     <- rowSums(a_mat[, 1:6] * (x_mat - p_mat[, 1:6])^2)
  outer     <- sum(alpha * exp(-inner))

  y <- -(2.58 + outer) / 1.94
  return(y)
}
