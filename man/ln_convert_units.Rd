% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/convert.R
\name{ln_convert_units}
\alias{ln_convert_units}
\title{Convert values to the default units for the lab}
\usage{
ln_convert_units(values, units, lab)
}
\arguments{
\item{values}{a vector of lab values}

\item{units}{the units of the lab values. See \code{LAB_DETAILS$units} for a list of available units for each lab. If different values have different units then this should be a vector of the same length as \code{values}.}

\item{lab}{the lab name. See \code{LAB_DETAILS$short_name} for a list of available labs.}
}
\value{
the values converted to the default units for the lab
}
\description{
Convert values to the default units for the lab
}
\examples{

# emulate a dataset with different units

hemoglobin_diff_units <- hemoglobin_data

# first 50 values will be in mg/ML
hemoglobin_diff_units$value[1:50] <- hemoglobin_diff_units$value[1:50] * 10

# last 50 values will be in mmol/L
hemoglobin_diff_units$value[51:100] <- hemoglobin_diff_units$value[51:100] / 1.61


converted <- ln_convert_units(
    hemoglobin_diff_units$value[1:100],
    c(rep("mg/mL", 50), rep("mmol/L", 50)),
    "Hemoglobin"
)

head(converted)
head(hemoglobin_data$value)
}
