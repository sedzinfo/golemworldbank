##########################################################################################
#
##########################################################################################
#' @title Path to a file installed with the app
#' @description `system.file()` for this package: finds the files of `inst/` (the
#' `www` folder, `golem-config.yml`) whether the package is installed or loaded
#' with `pkgload::load_all()`. The package name is written here, in
#' DESCRIPTION and in `inst/golem-config.yml`; when renaming the package,
#' change all three, or use `golem::set_golem_name()`.
#' @param ... Character vectors, giving the subdirectory and file(s) inside
#'   `inst/`. Without any, the root of the installed package.
#' @return The full path, or `""` if the file does not exist.
#' @noRd
#' @examples
#' \dontrun{
#' app_sys("app/www")
#' app_sys("golem-config.yml")
#' }
app_sys <- function(...) {
  system.file(..., package = "golemworldbank")
}
##########################################################################################
#
##########################################################################################
#' @title Read a value of the app configuration
#' @description Reads `inst/golem-config.yml`, the golem settings of the app (its name,
#' version, whether it runs in production), for the active configuration.
#' @param value Name of the value to read.
#' @param config Configuration to read: the environment variable
#'   `GOLEM_CONFIG_ACTIVE`, or else `R_CONFIG_ACTIVE`, or else `"default"`.
#' @param use_parent Logical. Look for the file in the parent directories too.
#' @param file Path of the configuration file.
#' @return The value, as [config::get()] returns it.
#' @noRd
#' @examples
#' \dontrun{
#' get_golem_config("golem_name")
#' get_golem_config("app_prod")
#' }
get_golem_config <- function(
    value,
    config = Sys.getenv("GOLEM_CONFIG_ACTIVE",
                        Sys.getenv("R_CONFIG_ACTIVE","default")),
    use_parent = TRUE,
  # Modify this if your config file is somewhere else
  file = app_sys("golem-config.yml")
) {
  config::get(value = value,config = config,file = file,use_parent = use_parent)
}
