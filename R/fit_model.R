#' Fit model and time it
#'
#' @param model_variant Model variant (GP, DGP2, DGP3)
#' @param x_mat Training data matrix
#' @param y Training data vector
#' @param n_mcmc Number of MCMC iterations
#' @return List containing model and time
fit_model <- function(model_variant, x_mat, y, n_mcmc) {

  # load required files
  source("R/scale_x.R")
  source("R/scale_y.R")

  # Fit model and time it
  start_time <- proc.time()[3]

  # Scale x_mat to [0,1] and y to mean 0, variance 1
  x_object <- scale_x(x = x_mat, reverse = FALSE)
  x_scaled <- x_object$scaled
  x_min    <- x_object$x_min
  x_max    <- x_object$x_max
  y_object <- scale_y(y = y, reverse = FALSE)
  y_scaled <- y_object$scaled
  y_mean   <- y_object$y_mean
  y_sd     <- y_object$y_sd

  # Fit model
  mod <- switch(
    as.character(model_variant),
    # Standard GP model
    "GP"   = deepgp::fit_one_layer(
      x      = x_scaled,
      y      = y_scaled,
      nmcmc  = n_mcmc
    ),
    # 2-layer Deep GP model
    "DGP2" = deepgp::fit_two_layer(
      x      = x_scaled,
      y      = y_scaled,
      nmcmc  = n_mcmc
    ),
    # 3-layer Deep GP model
    "DGP3" = deepgp::fit_three_layer(
      x      = x_scaled,
      y      = y_scaled,
      nmcmc  = n_mcmc
    ),
    stop(paste("Unknown model variant:", model_variant))
  )

  # Calculate time taken
  time_value   <- proc.time()[3] - start_time
  mod$runtime  <- time_value
  mod$x_scaled <- x_scaled
  mod$y_scaled <- y_scaled
  mod$x_min    <- x_min
  mod$x_max    <- x_max
  mod$y_mean   <- y_mean
  mod$y_sd     <- y_sd
  modfit2      <- deepgp::trim(mod, n_mcmc / 2, 2)
}