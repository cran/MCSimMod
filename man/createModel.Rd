% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/createModel.R
\name{createModel}
\alias{createModel}
\title{Function to create an MCSimMod Model object}
\usage{
createModel(mName = character(0), mString = character(0), writeTemp = TRUE)
}
\arguments{
\item{mName}{Name of an MCSim model specification file, excluding the file name extension \code{.model}.}

\item{mString}{A character string containing MCSim model specification text.}

\item{writeTemp}{Boolean specifying whether to write model files to a temporary directory. If value is TRUE (the default), model files will be Written to a temporary directory; if value is FALSE, model files will be Written to the same directory that contains the model specification file.}
}
\value{
Model object.
}
\description{
This function creates a \code{Model} object using an MCSim model specification
file or an MCSim model specification string.
}
\examples{
\dontrun{
# Simple model
mod <- createModel("path/to/model")

# Load/compile the model
mod$loadModel()

# Update parameters (P1 and P2)
mod$updateParms(c(P1 = 3, P2 = 1))

# Define times for ODE simulation
times <- seq(from = 0, to = 24, by = 0.1)

# Run the simulation
out <- mod$runModel(times)
}

}
