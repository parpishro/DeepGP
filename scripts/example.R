# Load R libraries
library(lhs) # For Latin Hypercube Sampling (design generation)
library(deepgp) # For fitting Deep Gaussian Processes
library(parallel) # For parallel processing
library(doParallel) # For parallel foreach
library(foreach) # For parallel iteration
library(dplyr) # For data manipulation

# Load all R files
files <- list.files("R", pattern = "\\.R$", full.names = TRUE)
lapply(files, source)

# Set seed for reproducibility
set.seed(123)

fn_name       <- "ackley"
dim           <- 10
n_train       <- 50
n_test        <- 1000
model_variant <- "DGP3"
noise_level   <- 0
rep           <- 1
n_mcmc         <- 2000

# Get test function and generate data
test_fn       <- get_function(fn_name)
x_train       <- generate_data(fn_name, n_train, dim)
y_train       <- evaluate_function(x_train, test_fn, noise_level)

# Fit model and time it
mod           <- fit_model(model_variant, x_train, y_train, n_mcmc)
time_value    <- mod$runtime

# Generate test data and evaluate
x_test        <- generate_data(fn_name, n_test, dim)
y_test        <- evaluate_function(x_test, test_fn, noise_level)

# Use predict_deepgp instead of direct predict
mod           <- predict_deepgp(mod, x_test)
y_hat         <- mod$y_hat

# Calculate RMSE and coverage using the mean predictions and 95% intervals
rmse_value    <- sqrt(mean((y_hat$mean - y_test)^2))
coverage_value <- mean(y_test >= y_hat$lower & y_test <= y_hat$upper) * 100
