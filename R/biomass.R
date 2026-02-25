#' Calculate Biomass Index
#' Calculate biomass index from CPUE and area swept
#'
#' @param cpue Numeric vector of CPUE values
#' @param area_swept Numeric vector of area swept (eg km squared)
#' @param catch Optional numeric vector of catch. If provided with `effort`,
#'   CPUE is computed via `cpue()`.
#' @param effort Optional numeric vector of effort. Required if `catch` is
#'   provided.
#' @param ... Additional arguments passed to `cpue()` when computing from
#'   catch and effort (e.g., `method`, `gear_factor`).
#'
#' @returns Numeric vector of biomass index values
#' @export
#'
#' @examples
#' salmon_cpue <- cpue(catch = 2, effort = 2)
#' biomass_index(cpue = salmon_cpue, area_swept = 5)
biomass_index <- function(cpue = NULL,
                          area_swept,
                          catch = NULL,
                          effort = NULL,
                          ...) {
  rlang::check_dots_used()
#if you have not provided cpue and you have provided catch + effort
  if (is.null(cpue) && (!is.null(catch) && !is.null(effort))){
    cpue <- cpue(catch, effort, ...)
  }

  cpue * area_swept
}
