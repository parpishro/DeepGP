#' Scale standardized predictions back to original scale
#'
#' @param y The original data
#' @param y_scaled The scaled predictions (mean, lower, upper, Sigma)
#' @param reverse If TRUE, reverses the scaling transformation
#' @return A list with scaled predictions (pred, lower, upper, Sigma)
#' @export
scale_y <- function(
    y = NULL, y_scaled = NULL,
    y_mean = NULL, y_sd = NULL,
    reverse = FALSE) {
  if (!reverse) {
    if (is.null(y)) {
      stop("y must be provided when reverse is FALSE")
    }
    # Scale the mean predictions
    y_mean   <- if (is.null(y_mean)) mean(y)
    y_sd     <- if (is.null(y_sd)) sd(y)
    scaled   <- (y - y_mean) / y_sd
    y_scaled <- list(scaled = scaled, y_mean = y_mean, y_sd = y_sd)
    return(y_scaled)

  } else {
    if (is.null(y_scaled)) {
      stop("y_scaled must be provided when reverse is TRUE")
    }
    # Reverse scaling
    y        <- y_scaled * y_sd + y_mean
    return(y)
  }
}
