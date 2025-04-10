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
# "pred_prey.model" included in the MCSimMod package.
pp_mod_name <- file.path(mod_path, "pred_prey")
pp_mod <- createModel(pp_mod_name)

## ----results='hide'-----------------------------------------------------------
# Load the model.
pp_mod$loadModel()

## ----echo=TRUE----------------------------------------------------------------
pp_mod$parms
pp_mod$Y0

## ----results='hide'-----------------------------------------------------------
# Define output times for simulation.
times <- seq(from = 0, to = 50, by = 0.1)

# Run simulation.
out <- pp_mod$runModel(times)

## ----echo=FALSE, results='asis'-----------------------------------------------
library(knitr)
kable(out[1:5, ])

## ----fig.dim=c(6, 4), fig.align='center'--------------------------------------
# Plot simulation results (numbers vs. time).
plot(out[, "time"], out[, "x"],
  type = "l", lty = 1, lwd = 2,
  xlab = "Time (d)", ylab = "Number (1000s)", ylim = c(0, 2)
)
lines(out[, "time"], out[, "y"], lty = 2, lwd = 2)
legend("topright", c("Rabbits", "Foxes"),
  lty = c(1, 2),
  lwd = 2
)

## ----fig.dim=c(6, 4), fig.align='center'--------------------------------------
# Plot simulation results (number of foxes vs. number of rabbits).
plot(out[, "x"], out[, "y"],
  type = "l", lty = 1, lwd = 2,
  xlab = "Number of Rabbits (1000s)", ylab = "Number of Foxes (1000s)"
)

## ----results='hide'-----------------------------------------------------------
# Remove output files that were created when building the model.
pp_mod$cleanup()

