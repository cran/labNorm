% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/utils.R
\name{ln_lab_units}
\alias{ln_lab_units}
\alias{ln_lab_default_units}
\title{Get available units for a lab}
\usage{
ln_lab_units(lab)

ln_lab_default_units(lab)
}
\arguments{
\item{lab}{the lab name. See \code{LAB_DETAILS$short_name} for a list of available labs.}
}
\value{
a vector of available units for the lab

the default units for the lab
}
\description{
Get available units for a lab

Get the default units for a lab
}
\examples{
ln_lab_units("Hemoglobin")

ln_lab_default_units("Hemoglobin")
}
