#' Evaluate the test function with noise
#'
#' @param x_mat Training data matrix
#' @param test_fn Test function
#' @param noise_level Noise level
#' @return Training data matrix with noise
evaluate_function <- function(x_mat, test_fn, noise_level) {
  # Apply test function row by row and add noise if specified
  y <- apply(x_mat, 1, test_fn)
  if (noise_level > 0) {
    y <- rnorm(nrow(x_mat), mean = y, sd = sd(y) * noise_level)
  }
  y
}