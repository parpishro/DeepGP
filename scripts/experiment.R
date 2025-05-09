# Main script for running DeepGP experiments
#
# This script sets up and runs a factorial experiment comparing
# standard GP models with 2-layer and 3-layer Deep Gaussian Process models
# across different test functions, sample sizes, and noise levels.

# Load required libraries
library(dplyr, warn.conflicts = FALSE) # For data manipulation

# Load required files
source("R/generate_design.R")
source("R/run_experiment.R")

# Set seed for reproducibility
seed <- 548
# Generate the factorial design
design <- generate_design(seed = seed)
cat(sprintf("Created design with %d experimental conditions.\n", nrow(design)))

# Run the experiments
results <- run_experiment(design, seed = seed)


# Save results to CSV
output_file <- "results/simulation_results.csv"
write.csv(results, output_file, row.names = FALSE)

# Print summary
cat(sprintf("\nSimulation complete. Results saved to '%s'.\n", output_file))

# Generate a simple summary table
# Use proper variable referencing with dplyr
summary <- group_by(
  results,
  test_function,
  model_variant,
  sample_size,
  noise_level
) %>%
  summarize(
    nrmse_mean     = mean(nrmse),
    nrmse_sd       = sd(nrmse),
    r2_mean       = mean(r2),
    r2_sd         = sd(r2),
    is_mean       = mean(is),
    is_sd         = sd(is),
    time_mean     = mean(time),
    time_sd       = sd(time),
    .groups = "drop"
  )

# Print formatted summary table
cat("\nSummary Results:\n")
cat("----------------\n")
print(summary)

# Save summary to CSV
summary_file <- "results/summary_results.csv"
write.csv(summary, summary_file, row.names = FALSE)

# Print completion message
cat(sprintf("\nSummary statistics saved to '%s'.\n", summary_file))
