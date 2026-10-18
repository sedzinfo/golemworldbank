##########################################################################################
# DIRECTORIES
##########################################################################################
# R CMD check worldbankmodular
# R CMD Rd2pdf worldbankmodular
# R CMD build worldbankmodular --resave-data
library(devtools)
library(roxygen2)
rm(list = ls())
graphics.off()
cat("\014")
##########################################################################################
# FUNCTIONS PACKAGE
##########################################################################################
directory <- dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(directory)
# usethis::create_package("worldbankmodular")
# usethis::use_data(mfi,mfi_cor,mfi_population,overwrite=TRUE)
# usethis::use_data_raw(name='data/mfi.rda')
# usethis::use_data_raw(name='data/mfi_cor.rda')
# usethis::use_data_raw(name='data/mfi_population.rda')
document()
if ("worldbankmodular" %in% rownames(installed.packages())) remove.packages("worldbankmodular")
install()
library(worldbankmodular)

pkgdown::build_site(getwd())
system("R CMD Rd2pdf . --force --no-preview --output=worldbankmodular.pdf")
if (.Platform$OS.type == "windows") shell.exec("worldbankmodular.pdf") else system("evince worldbankmodular.pdf")
system("R CMD build . --resave-data")

worldbankmodular::run_app() # starts the app: the console stays busy until you close it
