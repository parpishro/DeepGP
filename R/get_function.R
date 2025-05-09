#' Get test function
#'
#' @param fn_name Name of the test function
#' @return Test function
get_function <- function(fn_name) {
  # Load test functions
  source("R/ackley.R")
  source("R/hart6.R")
  source("R/branin.R")
  source("R/michalewicz.R")
  source("R/rosenbrock.R")
  source("R/curretal88exp.R")

  switch(as.character(fn_name),
    "ackley"      = ackley,
    "hart6"       = hart6,
    "branin"      = branin,
    "michalewicz" = michalewicz,
    "rosenbrock"  = rosenbrock,
    "curretal88exp" = curretal88exp,
    stop(paste("Unknown function name:", fn_name))
  )
}