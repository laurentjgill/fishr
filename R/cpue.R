#' Calculate catch per unit effort (CPUE)
#'
#' @param catch Numeric vector of catch
#' @param effort Numeric vector of effort
#' @param gear_factor Numeric adjustment for gear standard
#' @param method Character: one of "ratio" or "log"
#' @param verbose Logical indicating whether to print processing messages (default is FALSE), Also accpets the value of fishr.verbose
#'
#' @returns A numeric vector of CPUE values
#' @export
#'
#' @examples
#' cpue(100, 10)
#' cpue(100, 10, gear_factor = 0.5)
cpue <- function(catch,
                 effort,
                 gear_factor = 1 ,
                 method = c("ratio", "log"),
                 verbose = getOption("fishr.verbose", default = FALSE)) {

  if(verbose){
    message("Processing ", length(catch), " records")
  }

  #throws an error if its not ratio or log
  method <- match.arg(method)

  raw_cpue <- switch(
    method,
    ratio = catch/effort,
    log = log(catch/effort)
  )

  raw_cpue * gear_factor
}
