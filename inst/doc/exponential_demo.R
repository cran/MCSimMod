## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  warning = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(MCSimMod)

## ----results='hide'-----------------------------------------------------------
# Get the full name of the package directory that contains the example MCSim
# model specification file.
mod_path <- file.path(system.file(package = "MCSimMod"), "extdata")

# Create a model object using the example MCSim model specification file
# "exponential.model" included in the MCSimMod package.
exp_mod_name <- file.path(mod_path, "exponential")
exp_mod <- createModel(exp_mod_name)

## ----results='hide'-----------------------------------------------------------
# Load the model.
exp_mod$loadModel()

## ----results='hide'-----------------------------------------------------------
# Change the values of the model parameters from their default values: set the
# initial amount (A0) to 100 and the exponential rate (r) to -0.5.
exp_mod$updateParms(c(A0 = 100, r = -0.5))

# Update the initial value(s) of the state variable(s) based on the updated
# parameter value(s).
exp_mod$updateY0()

## ----results='hide'-----------------------------------------------------------
# Define output times for simulation.
times <- seq(from = 0, to = 20, by = 0.1)

# Run simulation.
out <- exp_mod$runModel(times)

## ----echo=FALSE, results='asis'-----------------------------------------------
library(knitr)
kable(out[1:5, ])

## ----echo=TRUE----------------------------------------------------------------
exp_mod$parms
exp_mod$Y0

## ----fig.dim=c(6, 4), fig.align='center'--------------------------------------
# Plot simulation results.
plot(out[, "time"], out[, "A"],
  type = "l", lty = 1, lwd = 2,
  xlab = "Time", ylab = "Amount"
)

