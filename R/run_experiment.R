#' Evaluate Factorial Design for GP and DGP Models
#'
#' @param design    A data frame with columns TestFunction, ModelVariant,
#'                  SampleSize, NoiseLevel, and Replication.
#' @param fn_dims   A named list specifying dimensions for test functions.
#' @param n_mcmc    Number of MCMC iterations for model fitting.
#' @param n_test    Number of test points to generate for evaluation.
#' @param seed      Random seed for reproducibility.
#'
#' @return A data frame with results.
#' @export
run_experiment <- function(
  design,
  fn_dims  = list(
    "ackley"        = 10, # 10D Ackley function
    "hart6"         = 6, # 6D Hartmann function
    "branin"        = 2, # 2D Branin function
    "michalewicz"   = 5, # 5D Michalewicz function
    "rosenbrock"    = 4, # 4D Rosenbrock function
    "curretal88exp" = 2 # 2D Currin et al. (1988) exponential function
  ),
  n_mcmc    = 2000, 
  n_test    = 1000,
  seed      = 548
) {

  # Load parallel processing dependencies
  library(parallel, quietly = TRUE, warn.conflicts = FALSE)
  library(doParallel, quietly = TRUE, warn.conflicts = FALSE)
  library(foreach, quietly = TRUE, warn.conflicts = FALSE)

  # Source all required files at the beginning
  # This ensures all functions are defined in the parent environment
  # before setting up the parallel cluster
  # Load the R files
  files <- list.files("R", pattern = "\\.R$", full.names = TRUE)
  invisible(lapply(files, source))

  # Setup parallel processing and load dependencies
  cl <- setup_parallel(env = environment(), seed = seed)

  # Run the design in parallel
  results <- foreach::foreach(
    i         = seq_len(nrow(design)),
    .combine  = rbind,
    .packages = c("lhs", "deepgp")
  ) %dopar% {
    analyze_combo(design[i, ], fn_dims, n_mcmc, n_test, seed)
  }

  # Stop the cluster
  stopCluster(cl)

  # Return results
  results
}