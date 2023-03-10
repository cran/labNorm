% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/normalize.R
\name{ln_normalize}
\alias{ln_normalize}
\alias{ln_normalize_multi}
\title{Normalize lab values to age and sex}
\usage{
ln_normalize(
  values,
  age,
  sex,
  lab,
  units = NULL,
  reference = "Clalit",
  na.rm = FALSE
)

ln_normalize_multi(labs_df, reference = "Clalit", na.rm = FALSE)
}
\arguments{
\item{values}{a vector of lab values}

\item{age}{a vector of ages between 20-89 for "Clalit" reference and 35-80 for "UKBB". Can be a single value if all values are the same age.}

\item{sex}{a vector of either "male" or "female". Can be a single value if all values are the same sex.}

\item{lab}{the lab name. See \code{LAB_DETAILS$short_name} for a list of available labs.}

\item{units}{the units of the lab values. See \code{ln_lab_units(lab)} for a list of available units for each lab. If \code{NULL} then the default units (\code{ln_lab_default_units(lab)}) for the lab will be used. If different values have different units then this should be a vector of the same length as \code{values}.}

\item{reference}{the reference distribution to use. Can be either "Clalit" or "UKBB" or "Clalit-demo". Please download the Clalit and UKBB reference distributions using \code{ln_download_data()}.}

\item{na.rm}{if \code{TRUE}, then \code{NA} in age, sex or values will be ignored and 'NA' would be returned. Otherwise, an error will be thrown.}

\item{labs_df}{a data frame with the columns "value", "age", "sex", "units", and "lab". The "lab" column should be a vector with the lab name per row. See \code{ln_normalize} for details on the other columns.}
}
\value{
a vector of normalized values. If \code{ln_download_data()} was not run, a lower resolution reference distribution will be used, which can have an error of up to 5 quantiles (0.05). Otherwise, the full reference distribution will be used. You can check if the high resolution data was downloaded using \code{ln_data_downloaded()}. \cr
You can force the function to use the lower resolution distribution by setting \code{options(labNorm.use_low_res = TRUE)}. \cr
If the quantile information is not available (e.g. "Estradiol" for male patients, various labs which are not available in the UKBB data), then the function will return \code{NA}.
}
\description{
Normalize standard laboratory measurements (e.g. hemoglobin, cholesterol levels) according to age and sex, based on the algorithms described in "Personalized lab test models to quantify disease potentials in healthy individuals" \doi{10.1038/s41591-021-01468-6}. \cr \cr
The "Clalit" reference distributions are based on 2.1B lab measurements taken from 2.8M individuals between 2002-2019, filtered to exclude severe chronic diseases and medication effects. The resulting normalized value is a quantile between 0 and 1, representing the value's position in the reference distribution. \cr \cr
The "UKBB" reference distributions are based on the UK-Biobank, a large-scale population-based cohort study of 500K individuals, which underwent the same filtering process as the "Clalit" reference distributions.
\cr \cr
The list of supported labs can be found below or by running \code{LAB_DETAILS$short_name}.
}
\section{reference distribution}{

It is highly recommended to use \code{ln_download_data} to download the "Clalit" and "UKBB" reference distributions. If you choose not to download the data, the package will use the demo reference distributions included in the package ("Clalit-demo"), which doesn't include all the labs, and has a resolution of 20 quantile bins and therefore may have an error of up to 5 percentiles (0.05), particularly at the edges of the distribution. \cr
}

\section{labs}{

The following labs are supported in the "Clalit" reference (some labs are missing from the UKBB reference): \cr
\itemize{
\item WBC
\item RBC
\item Hemoglobin
\item Hematocrit
\item Platelets
\item MCV
\item MCH
\item MCHC
\item RDW
\item MPV
\item Large unstained cells, Abs
\item Albumin
\item Total Cholesterol
\item Triglycerides
\item BMI
\item Iron
\item Transferrin
\item Ferritin
\item PDW
\item MPXI
\item Total Globulin
\item PCT
\item HDW
\item Fibrinogen
\item CH
\item Chloride
\item Large unstained cells, \%
\item Macrocytic
\item Microcytic
\item Hyperchromic
\item Hypochromic
\item Lymphocytes, Abs
\item Lymphocytes, \%
\item Neutrophils, Abs
\item Neutrophils, \%
\item Monocytes, Abs
\item Monocytes, \%
\item Eosinophils, Abs
\item Eosinophils, \%
\item Basophils, Abs
\item Basophils, \%
\item Microcytic:Hypochromic
\item Glucose
\item Urea
\item Creatinine
\item Uric Acid
\item Calcium
\item Phosphorus
\item Total Protein
\item HDL Cholesterol
\item LDL Cholesterol
\item Alk. Phosphatase
\item AST
\item ALT
\item GGT
\item LDH
\item CPK
\item Total Bilirubin
\item Direct Bilirubin
\item Hemoglobin A1c
\item Sodium
\item Potassium
\item Vitamin D (25-OH)
\item Microalbumin:Creatinine
\item Urine Creatinine
\item Urine Microalbumin
\item Non-HDL
\item TSH
\item T3, Free
\item T4, Free
\item Blood Pressure, Systolic
\item Blood Pressure, Diastolic
\item Urine Specific Gravity
\item Urine pH
\item PT, INR
\item PT, sec
\item PT, \%
\item Vitamin B12
\item PSA
\item ESR
\item aPTT, sec
\item CRP
\item Amylase
\item Folic Acid
\item Total:HDL
\item Hematocrit:Hemoglobin
\item Magnesium
\item aPTT, ratio
\item Indirect Bilirubin
\item RDW-SD
\item RDW-CV
\item LH
\item Estradiol
}
}

\examples{
\donttest{
# Normalize Hemoglobin values to age and sex
hemoglobin_data$quantile <- ln_normalize(
    hemoglobin_data$value,
    hemoglobin_data$age,
    hemoglobin_data$sex,
    "Hemoglobin"
)

# plot the quantiles vs values for age 50-60
library(ggplot2)
library(dplyr)
hemoglobin_data \%>\%
    filter(age >= 50 & age <= 60) \%>\%
    ggplot(aes(x = value, y = quantile, color = sex)) +
    geom_point() +
    theme_classic()

# Different units
hemoglobin_diff_units <- hemoglobin_data
hemoglobin_diff_units$value <- hemoglobin_diff_units$value * 0.1
hemoglobin_diff_units$quantile <- ln_normalize(
    hemoglobin_data$value,
    hemoglobin_data$age,
    hemoglobin_data$sex,
    "Hemoglobin",
    "mg/mL"
)

# Multiple units
creatinine_diff_units <- creatinine_data
creatinine_diff_units$value <- c(
    creatinine_diff_units$value[1:500] * 0.011312,
    creatinine_diff_units$value[501:1000] * 11.312
)
creatinine_diff_units$quantile <- ln_normalize(
    creatinine_diff_units$value,
    creatinine_diff_units$age,
    creatinine_diff_units$sex,
    "Creatinine",
    c(rep("umol/L", 500), rep("mmol/L", 500))
)

# Use UKBB as reference
hemoglobin_data_ukbb <- hemoglobin_data \%>\% filter(age >= 35 & age <= 80)
hemoglobin_data_ukbb$quantile_ukbb <- ln_normalize(
    hemoglobin_data_ukbb$value,
    hemoglobin_data_ukbb$age,
    hemoglobin_data_ukbb$sex,
    "Hemoglobin",
    reference = "UKBB"
)

# plot UKBB vs Clalit
hemoglobin_data_ukbb \%>\%
    filter(age >= 50 & age <= 60) \%>\%
    ggplot(aes(x = quantile, y = quantile_ukbb, color = sex)) +
    geom_point() +
    geom_abline() +
    theme_classic()
}

# examples on the demo data
\dontshow{
hemoglobin_data$quantile <- ln_normalize(
    hemoglobin_data$value,
    hemoglobin_data$age,
    hemoglobin_data$sex,
    "Hemoglobin",
    reference = "Clalit-demo"
)
}

library(dplyr)
multi_labs_df <- bind_rows(
    hemoglobin_data \%>\% mutate(lab = "Hemoglobin"),
    creatinine_data \%>\% mutate(lab = "Creatinine")
)

\donttest{
multi_labs_df$quantile <- ln_normalize_multi(multi_labs_df)
}

# on the demo data
\dontshow{
multi_labs_df$quantile <- ln_normalize_multi(multi_labs_df, reference = "Clalit-demo")
}

head(multi_labs_df)

}
