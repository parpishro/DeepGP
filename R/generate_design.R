#' Generate Factorial Design for DeepGP Experiments
#'
#' Creates a factorial experimental design for comparing standard GP models with
#' 2-layer and 3-layer Deep Gaussian Process models across different test
#' functions, sample sizes, and optional noise levels.
#'
#' @param test_functions Character vector of test function names to include in
#'                       the design. Default includes all five test functions:
#'                       ackley, hart6, branin, michalewicz, and rosenbrock.
#' @param model_variants Character vector of model types to include in the
#'                       design. Default includes GP (standard), DGP2 (2-layer),
#'                       and DGP3 (3-layer).
#' @param sample_sizes   Numeric vector of sample sizes to include in the
#'                       design. Default is c(20, 50, 100) for small, medium,
#'                       and large training sets.
#' @param noise_levels   Numeric vector of noise standard deviations to include
#'                       in the design. Default is 0 (no noise).
#' @param replications   Number of replications for each experimental condition.
#'                       Default is 5.
#'
#' @return A data frame containing all factorial combinations of the input
#'         factors, with columns for TestFunction, ModelVariant, SampleSize,
#'         NoiseLevel, and Replication.
#' @export
#'
#' @examples
#' # Generate default full design
#' design <- generate_design()
#'
#' # Generate design with specific test functions and larger sample sizes
#' design <- generate_design(
#'   test_functions = c("branin", "hart6"),
#'   sample_sizes = c(50, 100, 200)
#' )
#'
#' # Generate design with noise
#' design <- generate_design(noise_levels = c(0, 0.1))
generate_design <- function(
  test_functions = c(
    "ackley", "hart6", "branin", "michalewicz", "rosenbrock", "curretal88exp"
  ),
  model_variants = c("GP", "DGP2", "DGP3"),
  sample_sizes   = c(20, 50, 100),
  noise_levels   = c(0, 0.35),
  replications   = 5,
  seed           = 548
) {
  
  # Set seed for reproducibility
  set.seed(seed)

  # Create base factorial design
  design <- expand.grid(
    test_function = test_functions,
    model_variant = model_variants,
    sample_size   = sample_sizes,
    noise_level   = noise_levels,
    replication  = 1:replications
  )

  # Add row ID for tracking
  design$id <- seq_len(nrow(design))

  return(design)
}
