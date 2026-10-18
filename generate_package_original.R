##########################################################################################
# DIRECTORIES
##########################################################################################
# R CMD check worldbankmodular
# R CMD Rd2pdf worldbankmodular
# R CMD build worldbankmodular --resave-data
library(devtools)
library(roxygen2)
rm(list=ls())
directory<-dirname(rstudioapi::getActiveDocumentContext()$path)
setwd(directory)
getwd()
# usethis::create_package("worldbankmodular")
# usethis::use_data(mfi,mfi_cor,mfi_population,overwrite=TRUE)
# usethis::use_data_raw(name='data/mfi.rda')
# usethis::use_data_raw(name='data/mfi_cor.rda')
# usethis::use_data_raw(name='data/mfi_population.rda')
devtools::document()
devtools::install()
library(worldbankmodular)


help(package="worldbankmodular")
worldbankmodular::run_app()

pkgdown::build_site()

system("R CMD Rd2pdf ../worldbankmodular --force --output=worldbankmodular.pdf")
system("R CMD build ../worldbankmodular --resave-data")


