#' Generate data
#'
#' @param fn_name Name of the test function
#' @param n_sample Number of training points
#' @param dim Dimension of the test function
#' @return Training data matrix
generate_data <- function(fn_name, n_sample, dim) {

  # Generate training data
  x_mat <- switch(
    as.character(fn_name),
    # Scale from [0,1] to [-32, 32]
    "ackley"      = randomLHS(n_sample, dim) * 2 * 32.768 - 32.768,
    # Uses default [0,1] range
    "hart6"       = randomLHS(n_sample, dim),
    # x1 in [-5, 10], x2 in [0, 15]
    "branin"      = cbind(
      randomLHS(n_sample, 1) * 15 - 5,
      randomLHS(n_sample, 1) * 15
    ),
    # Scale from [0,1] to [0, π]
    "michalewicz" = randomLHS(n_sample, dim) * pi,
    # Scale from [0,1] to [-5, 10]
    "rosenbrock"  = randomLHS(n_sample, dim) * 15 - 5,
    "curretal88exp" = randomLHS(n_sample, dim),
    stop(paste("Unknown function name:", fn_name))
  )
  x_mat
}