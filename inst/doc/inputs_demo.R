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
# "pk1_input.model" included in the MCSimMod package.
pk1_mod_name <- file.path(mod_path, "pk1_input")
pk1_mod <- createModel(pk1_mod_name)

## ----results='hide'-----------------------------------------------------------
# Load the model.
pk1_mod$loadModel()

## -----------------------------------------------------------------------------
pk1_mod$parms
pk1_mod$Y0

## -----------------------------------------------------------------------------
# Define body mass input.
M_table <- cbind(times = c(0, 20), M_in = c(0.25, 1.0))
head(M_table)

## ----results='hide'-----------------------------------------------------------
# Define output times for simulation.
times <- seq(from = 0, to = 20, by = 0.1)

# Run simulation.
out <- pk1_mod$runModel(times, forcings = list(M_table))

## -----------------------------------------------------------------------------
# Define body mass input.
M_table2 <- cbind(times = c(0, 20), M_in = c(0.25, 0.25))

# Run simulation.
out2 <- pk1_mod$runModel(times, forcings = list(M_table2))

## ----echo=FALSE, results='asis'-----------------------------------------------
library(knitr)
kable(out[1:5, ])

## ----fig.dim=c(6, 4), fig.align='center'--------------------------------------
# Plot simulation results.
plot(out[, "time"], out[, "C"],
  type = "l", lty = 1, lwd = 2, xlab = "Time (h)",
  ylab = "Concentration (mg/L)", ylim = c(0, 2500)
)
lines(out2[, "time"], out2[, "C"], lty = 2, lwd = 2)
legend("topright",
  legend = c("Varying Body Mass", "Constant Body Mass"),
  lty = c(1, 2), lwd = 2
)

