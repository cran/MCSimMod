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
pk1_mod$updateParms(c(A0_init = 0))

# Update the initial value(s) of the state variable(s) based on the updated
# parameter value(s).
pk1_mod$updateY0()

## -----------------------------------------------------------------------------
pk1_mod$parms
pk1_mod$Y0

## -----------------------------------------------------------------------------
events_df <- data.frame(
  var = "A0", time = seq(from = 0, to = 48, by = 12), value = 50,
  method = "add"
)
head(events_df)

## ----results='hide'-----------------------------------------------------------
# Define output times for simulation.
times <- seq(from = 0, to = 48, by = 0.01)

# Run simulation.
out <- pk1_mod$runModel(times, events = list(data = events_df))

## ----echo=FALSE, results='asis'-----------------------------------------------
library(knitr)
kable(out[1199:1203, ])

## ----fig.dim=c(6, 4), fig.align='center'--------------------------------------
# Plot simulation results.
plot(out[, "time"], out[, "C"],
  type = "l", lty = 1, lwd = 2,
  xlab = "Time (h)", ylab = "Concentration (mg/L)"
)

