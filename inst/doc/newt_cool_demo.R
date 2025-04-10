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
# "newt_cool.model" included in the MCSimMod package.
newt_mod_name <- file.path(mod_path, "newt_cool")
newt_mod <- createModel(newt_mod_name)

## ----results='hide'-----------------------------------------------------------
# Load the model.
newt_mod$loadModel()

## ----results='hide'-----------------------------------------------------------
# Change the values of the model parameters from their default values.
newt_mod$updateParms(c(T0 = 95, Tamb = 22, r = 0.7))

# Update the initial value(s) of the state variable(s) based on the updated
# parameter value(s).
newt_mod$updateY0()

## ----results='hide'-----------------------------------------------------------
# Define output times for simulation.
times <- seq(from = 0, to = 5, by = 0.1)

# Run simulation.
out <- newt_mod$runModel(times)

## ----echo=FALSE, results='asis'-----------------------------------------------
library(knitr)
kable(out[1:5, ])

## ----echo=TRUE----------------------------------------------------------------
newt_mod$parms
newt_mod$Y0

## ----fig.dim=c(6, 4), fig.align='center'--------------------------------------
# Plot simulation results.
plot(out[, "time"], out[, "T"],
  type = "l", lty = 1, lwd = 2,
  xlab = "Time", ylab = "Temperature (C)", ylim = c(0, 100)
)
abline(h = newt_mod$parms[["Tamb"]], lty = 2, lwd = 2)
legend("topright", c("Tea", "Ambient Air"),
  lty = c(1, 2),
  lwd = c(2, 2)
)

