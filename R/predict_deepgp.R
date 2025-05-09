#' Make predictions with a GP or DGP model and calculate prediction intervals
#'
#' @param model   A fitted GP or DGP model from fit_one_layer, fit_two_layer, or
#'                fit_three_layer
#' @param x_test  Matrix of test points to predict at
#' @param alpha   Significance level for prediction intervals (default: 0.05 for
#'                95% intervals)
#' @return A list with elements: mean, lower, upper, and Sigma
#' @export
predict_deepgp <- function(mod, x_test, alpha = 0.05) {
  # Load required files
  source("R/scale_x.R")
  source("R/scale_y.R")

  # Ensure x_test is a matrix
  if (ncol(mod$x) != ncol(x_test)) {
    stop("x_test must have the same dimensions as mod$x")
  }

  # Scale x_test
  x_object <- scale_x(
    x = x_test,
    x_min = mod$x_min,
    x_max = mod$x_max,
    reverse = FALSE
  )
  x_scaled <- x_object$scaled

  # Make predictions
  mod <- predict(
    mod,
    x_new        = x_scaled,
    lite         = TRUE,
    return_all   = TRUE,
    store_latent = TRUE
  )


  y_hat <- data.frame(
    lower = scale_y(
      y_scaled = apply(mod$mean_all, 1, quantile, probs = alpha / 2),
      y_mean   = mod$y_mean,
      y_sd     = mod$y_sd,
      reverse  = TRUE
    ),
    mean  = scale_y(
      y_scaled = mod$mean,
      y_mean   = mod$y_mean,
      y_sd     = mod$y_sd,
      reverse  = TRUE
    ),
    upper = scale_y(
      y_scaled = apply(mod$mean_all, 1, quantile, probs = 1 - alpha / 2),
      y_mean   = mod$y_mean,
      y_sd     = mod$y_sd,
      reverse  = TRUE
    )
  )

  mod$y_hat <- y_hat

  # Return model with predictions
  mod
}