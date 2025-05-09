#' Setup parallel processing environment
#'
#' @param env The environment to export functions and variables to
#' @param seed The seed for reproducibility
#' @return A cluster object
setup_parallel <- function(env, seed) {

  # Load parallel processing dependencies
  library(parallel)
  library(doParallel)
  library(foreach, quietly = TRUE)

  # Setup parallel backend
  num_cores <- max(1, parallel::detectCores() - 2)
  cl        <- parallel::makeCluster(num_cores)
  doParallel::registerDoParallel(cl)
  cat(sprintf("Running experiments in parallel using %d cores...\n", num_cores))

  # Export all required functions and variables to the cluster
  # Use environment() so variables defined in this function scope are visible
  clusterExport(
    cl,
    c(
      "analyze_combo",
      "get_function",
      "generate_data",
      "evaluate_function",
      "fit_model",
      "predict_deepgp",
      "scale_x",
      "scale_y",
      "design",
      "fn_dims",
      "n_mcmc",
      "n_test"
    ),
    envir = env
  )

  # Initialize reproducible RNG streams on each worker
  parallel::clusterSetRNGStream(cl, seed)

  # Return the cluster object
  cl
}
