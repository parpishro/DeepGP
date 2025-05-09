#' Scale data for GP models
#'
#' This function scales input data X to [0,1] range. It can also reverse the
#' scaling to convert predictions back to the original scale.
#'
#' @param x Input matrix or vector to scale
#' @param x_scaled Scaled data (for reverse scaling)
#' @param reverse If TRUE, reverses the scaling transformation
#' @return A list containing scaled data and scaling parameters
#' @export
scale_x <- function(
  x = NULL, x_scaled = NULL,
  x_min = NULL, x_max = NULL,
  reverse = FALSE
) {

  if (!reverse) {

    # Check if x is provided
    if (is.null(x)) {
      stop("x must be provided when reverse is FALSE")
    }

    # Ensure x is a matrix
    if (!is.matrix(x)) {
      x <- as.matrix(x)
    }

    # Forward scaling (original data to [0,1])
    if (is.null(x_min) || is.null(x_max)) {
      x_min <- apply(x, 2, min)
      x_max <- apply(x, 2, max)
    }

    # Scale each column to [0,1]
    scaled <- t(apply(x, 1, function(row) (row - x_min) / (x_max - x_min)))
    x_scaled <- list(scaled = scaled, x_min = x_min, x_max = x_max)

    return(x_scaled)
  } else {
    # Reverse scaling (scaled data back to original scale)

    # Check if x_scaled is provided
    if (is.null(x_scaled)) {
      stop("x_scaled, x_min, and x_max must be provided when reverse is TRUE")
    }

    # Reverse the scaling for each column
    x <- t(apply(x_scaled, 1, function(row) row * (x_max - x_min) + x_min))

    return(x)
  }
}