## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  echo = TRUE,
  warning = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library(MCSimMod)

## ----results='hide'-----------------------------------------------------------
mod_string <- "
States = {y};
y0 = 2;
m = 0.5;
Initialize {
    y = y0;
}
Dynamics {
    dt(y) = m;
}
End.
"

## ----results='hide'-----------------------------------------------------------
model <- createModel(mString = mod_string)

## ----results='hide'-----------------------------------------------------------
model$loadModel()
times <- seq(from = 0, to = 20, by = 0.1)
out <- model$runModel(times)

## ----echo=FALSE, results='asis'-----------------------------------------------
library(knitr)
kable(out[1:5, ])

## -----------------------------------------------------------------------------
model$parms
model$Y0

## ----fig.dim=c(6, 4), fig.align='center'--------------------------------------
# Plot simulation results.
plot(out[, "time"], out[, "y"],
  type = "l", lty = 1, lwd = 2, xlab = "Time",
  ylab = "y"
)

