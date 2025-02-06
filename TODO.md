### Week 1: Setup and Preparation

1. **Read and Summarize Paper**  
   - Review Sauer et al. (2023) focusing on DGP setup and model fitting.  
   - Summarize key points in a few paragraphs (e.g., what is a DGP, how does it differ from a regular GP?).
   - Note any specific `deepgp` options or hyperparameters that are relevant for the experiments.
   - **Optional**: Read a few related papers on DGPs (e.g., Salimbeni & Deisenroth, 2017; Matthews et al., 2018).
   - Skim the `deepgp` package documentation in R.
   - Note any relevant R packages for GP modeling (e.g., `GaSP`, `laGP`, `mgcv`, `GPy`).
   - Note key R functions in `deepgp` for building 2- and 3-layer models.


2. **Select Example Functions**  
   - Pick ~3 test functions from the Virtual Library of Simulation Experiments (e.g., Branin, Hartmann, Goldstein–Price).  
   - Justify each function choice (different dimensionality, smoothness, complexity).
   - **Optional**: Add noise to the functions to simulate real-world data.
   - **Optional**: Consider adding a high-dimensional function (e.g., Rosenbrock) to test scalability.
   - **Optional**: Add a function with a hidden layer effect (e.g., a function with a local minimum).
   - **Optional**: Add a function with a non-stationary effect (e.g., a function with a changing gradient).
   - Generate a few plots showing the functions’ shapes and gradients.


3. **Design Simulation Strategy**  
   - Decide on sample sizes (e.g., 20, 50, 100) and factor combinations (e.g., 2-layer vs. 3-layer vs. regular GP).  
   - Choose a DGP fitting strategy (e.g., number of iterations, optimization method).
   - Decide on the number of replications per setting (e.g., 10, 20).
   - Define evaluation criteria for model comparison:
     - **Prediction Accuracy**: RMSE or MAE on test points.
     - **Uncertainty Estimation**: Coverage probability of 95% predictive intervals.
     - **Computational Time**: CPU time for model fitting and prediction.
   - Sketch a small experimental design table: factors = \{function, sample size, DGP-layers, relevant `deepgp` options\}.
   - **Optional**: Consider adding a few more factors (e.g., kernel choice, layer width) to explore more settings.

---

### Week 2-3: Implementation and Experimentation

4. **Code Setup in R**  
   - Write functions to:
     - Generate/design input points (e.g., Latin hypercube).
     - Define test functions (e.g., Branin, Hartmann).
     - Evaluate chosen test functions at those points.
     - Fit (a) standard GP model (e.g. using `laGP`, `mgcv`, or `GPy` in R)  
       and (b) 2-layer and 3-layer DGPs via `deepgp`.
     - Collect predictions on test grids.
     - Compute RMSE/MAE, coverage probability, and CPU time.
     - **Optional**: Add functions to visualize model predictions and uncertainties.
   - Ensure that the code is modular and well-documented.
   - **Optional**: Write a function to run a single simulation experiment (e.g., for a single function and sample size).

5. **Define a Proper Simulation Experiment Design**

    1. **Experimental Factors**  
        - **Test Function**: Select a few representative functions (e.g., Branin, Hartmann). Each function is a factor level.  
        - **Model Variant**: Single-layer GP vs. 2-layer DGP vs. 3-layer DGP.  
        - **Sample Size**: For each function, compare results at different training set sizes (e.g., 20, 50, 100).  
        - Possibly add **hyperparameter settings** or **kernel choices** if they are critical.

    2. **Factorial Structure**  
        - Cross all factor levels: \(\{\text{function}\} \times \{\text{model variant}\} \times \{\text{sample size}\}\).  
        - This yields a well-defined set of experimental conditions (design points) for systematic comparison.

    3. **Replicate Within Each Condition**  
        - **Random Seeds**: For each design point, generate several random seeds for:  
            1. The training design (e.g., random Latin hypercube).  
            2. The MCMC initialization in each model (if randomness is present).  
        - **Number of Replicates**: At least 5–10 replicates (or more if computationally feasible) to get stable estimates of predictive error and variability.

    4. **Collect Consistent Response Metrics**  
        - **Primary Response**: RMSE or MAE on a held-out test set.  
        - **Secondary Responses**: Coverage of predictive intervals, width of predictive intervals, runtime.  
        - Aggregate these metrics across replicates to get mean and variance estimates.

    5. **Analyze Results Using Standard Statistical Tools**  
        - **ANOVA or Mixed-Effects Modeling**: Treat “function,” “model variant,” and “sample size” as fixed factors. The replicate index can be random.  
        - **Multiple Comparisons**: Use post-hoc tests (e.g., Tukey’s HSD) or pairwise comparisons to see which model variant significantly outperforms others under which conditions.  
        - **Interaction Effects**: Check if advantage of deeper GPs changes by function type or sample size.

    6. **Space-Filling Designs for Each Replicate**  
        - Within each factor setting, use a **Latin hypercube** or other space-filling design for the training points.  
        - Use a sufficiently large test grid (or random test set) to accurately measure predictive performance.


5. **Run Simulation Experiments**  
   - Systematically vary sample size and DGP-layers.  
   - For each setting, store predictive accuracy (RMSE or MAE), coverage probability, CPU time, etc.  
   - Keep code reproducible (e.g., fix random seeds, structure code in clean scripts).

6. **Preliminary Analysis**  
   - Use simple tables/plots to compare performance of single-layer vs. multi-layer GPs.  
   - Note any interesting patterns (e.g., does 3-layer model help more for certain functions or sample sizes?).

---

### Week 4: Deeper Analysis and Write-Up

7. **Refine Plots and Diagnostics**  
   - Generate 1D or 2D slices showing model predictions vs. true surface.  
   - Visualize posterior standard deviations to see how uncertainty differs among models.  
   - Investigate model settings in `deepgp` (e.g., kernel choice, layer widths) only for a few relevant variants if time permits.

8. **Interpretation and Documentation**  
   - Summarize results in a short report:
     - **Introduction**: Briefly describe DGPs and motivation.  
     - **Methods**: Detail design of experiments, including how you selected functions, sample sizes, etc.  
     - **Results**: Show tables/figures comparing errors, coverage, runtime.  
     - **Discussion**: 
       - Conjecture why DGPs help or not for each function.  
       - Mention any hidden-layer effects observed in plots.  
     - **Conclusion**: State key findings (e.g., “2-layer DGP outperforms regular GP on Hartmann, but not on Branin…”).

9. **Final Checks**  
   - Proofread code and report.  
   - Ensure reproducibility (provide seed values, code snippets, etc.).  
   - Submit report and code to GitHub.  

---
