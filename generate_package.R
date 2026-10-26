##########################################################################################
# DIRECTORIES
##########################################################################################
# R CMD check golemworldbank
# R CMD Rd2pdf golemworldbank
# R CMD build golemworldbank --resave-data
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
# usethis::create_package("golemworldbank")
# usethis::use_data(mfi,mfi_cor,mfi_population,overwrite=TRUE)
# usethis::use_data_raw(name='data/mfi.rda')
# usethis::use_data_raw(name='data/mfi_cor.rda')
# usethis::use_data_raw(name='data/mfi_population.rda')
document()
if ("golemworldbank" %in% loadedNamespaces()) unloadNamespace("golemworldbank") # an old version still loaded would make the reinstalled one look corrupt
if ("golemworldbank" %in% rownames(installed.packages())) remove.packages("golemworldbank")
install()
library(golemworldbank)

pkgdown::build_site(getwd())
system("R CMD Rd2pdf . --force --no-preview --output=golemworldbank.pdf")
if (.Platform$OS.type == "windows") shell.exec("golemworldbank.pdf") else system("evince golemworldbank.pdf")
system("R CMD build . --resave-data")

golemworldbank::run_app()
