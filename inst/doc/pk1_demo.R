## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  warning = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----echo=FALSE, fig.cap="A classical PK model", out.width = '100%'-----------
knitr::include_graphics("pk1.png")

## -----------------------------------------------------------------------------
library(MCSimMod)

## ----results='hide'-----------------------------------------------------------
# Get the full name of the package directory that contains the example MCSim
# model specification file.
mod_path <- file.path(system.file(package = "MCSimMod"), "extdata")

# Create a model object using the example MCSim model specification file
# "pk1.model" included in the MCSimMod package.
pk1_mod_name <- file.path(mod_path, "pk1")
pk1_mod <- createModel(pk1_mod_name)

## ----results='hide'-----------------------------------------------------------
# Load the model.
pk1_mod$loadModel()

## ----results='hide'-----------------------------------------------------------
# Change the values of the model parameters from their default values.
pk1_mod$updateParms(c(k01 = 0.8, k12 = 0.4, Vd = 45, A0_init = 200))

# Update the initial value(s) of the state variable(s) based on the updated
# parameter value(s).
pk1_mod$updateY0()

## ----results='hide'-----------------------------------------------------------
# Define output times for simulation.
times <- seq(from = 0, to = 20, by = 0.1)

# Run simulation.
out_oral <- pk1_mod$runModel(times)

## ----echo=FALSE, results='asis'-----------------------------------------------
library(knitr)
kable(out_oral[1:5, ])

## -----------------------------------------------------------------------------
pk1_mod$parms
pk1_mod$Y0

## ----fig.dim=c(6, 4), fig.align='center'--------------------------------------
# Plot simulation results.
plot(out_oral[, "time"], out_oral[, "C"],
  type = "l", lty = 1, lwd = 2,
  xlab = "Time (h)", ylab = "Concentration (mg/L)"
)

## ----results='hide'-----------------------------------------------------------
# Change the values of the model parameters.
pk1_mod$updateParms(c(k12 = 0.4, Vd = 45, A0_init = 0, A1_init = 200))

# Update the initial value(s) of the state variable(s) based on the updated
# parameter value(s).
pk1_mod$updateY0()

## -----------------------------------------------------------------------------
pk1_mod$parms
pk1_mod$Y0

## ----results='hide'-----------------------------------------------------------
# Run simulation.
out_IV <- pk1_mod$runModel(times)

## ----fig.dim=c(6, 4), fig.align='center'--------------------------------------
# Plot simulation results.
plot(out_oral[, "time"], out_oral[, "C"],
  type = "l", lty = 1, lwd = 2,
  xlab = "Time (h)", ylab = "Concentration (mg/L)", ylim = c(0, 5)
)
lines(out_IV[, "time"], out_IV[, "C"], lty = 2, lwd = 2)
legend("topright", c("Oral", "IV"), lty = c(1, 2), lwd = 2)

## -----------------------------------------------------------------------------
out_oral[nrow(out_oral), "AUC"]
out_IV[nrow(out_IV), "AUC"]

