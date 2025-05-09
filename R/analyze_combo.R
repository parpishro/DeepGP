#' Run a single experiment from the design
#'
#' @param design_row A single row from the design data frame
#' @param fn_dims Named list of dimensions for test functions
#' @param n_mcmc Number of MCMC iterations
#' @param n_test Number of test points
#' @return A data frame row with results
analyze_combo <- function(design_row, fn_dims, n_mcmc, n_test, seed) {

  set.seed(seed*design_row$id)
  # Extract factor levels
  fn_name        <- design_row$test_function
  model_variant  <- design_row$model_variant
  n_sample       <- design_row$sample_size
  noise_level    <- design_row$noise_level
  rep            <- design_row$replication

  # Get test function and its input dimension
  test_fn        <- get_function(fn_name)
  dim            <- fn_dims[[fn_name]]

  # Generate training data while applying the noise on output
  x_train        <- generate_data(fn_name, n_sample, dim)
  y_train        <- evaluate_function(x_train, test_fn, noise_level)

  # Fit model and time it
  mod            <- fit_model(model_variant, x_train, y_train, n_mcmc)

  # Generate test data and apply the noise on output
  x_test         <- generate_data(fn_name, n_test, dim)
  y_test         <- evaluate_function(x_test, test_fn, noise_level)

  # Make predictions
  mod           <- predict_deepgp(mod, x_test)
  y_hat         <- mod$y_hat

  ## Coefficient of determination R²
  rss <- sum((y_hat$mean - y_test)^2)
  tss <- sum((y_test - mean(y_test))^2) 
  r2_val <- 1 - rss / tss

  ## nRMSE: RMSE scaled by σ̂ of the true responses
  nrmse_val <- sqrt(rss / n_test) / sd(y_test)

  ## Interval score ISα (Gneiting & Raftery 2007) for α = 0.05
  alpha <- 0.05
  is_val <- mean(
    (y_hat$upper - y_hat$lower) +                     # interval width
      (2 / alpha) * (y_hat$lower - y_test) * (y_test < y_hat$lower) +
      (2 / alpha) * (y_test - y_hat$upper) * (y_test > y_hat$upper)
  )

  # Print progress
  msg <- sprintf(
    "Completed model # %d (function: %s , variant: %s, sample size: %d, noise level: %.2f, replication: %d) nRMSE: %.4f IS: %.4f R2: %.4f\n",
    design_row$id, fn_name, model_variant,
    n_sample, noise_level, rep, nrmse_val, is_val, r2_val
  )
  write(msg, file = "log.txt", append = TRUE)

  # Return results as a data frame row
  data.frame(
    id            = design_row$id,
    test_function = fn_name,
    model_variant = model_variant,
    sample_size   = n_sample,
    noise_level   = noise_level,
    replication   = rep,
    dimension     = dim,
    nrmse         = nrmse_val,
    r2            = r2_val,
    is            = is_val,
    time          = mod$runtime
  )
}
