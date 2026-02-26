#' Calculate catch per unit effort (CPUE)
#'
#' @param ...  Additional arguments poassed to methods
#' @param catch Numeric vector of catch or a data frame with catch and effort columns
#'
#' @export
cpue <- function(catch, ...){
  UseMethod("cpue")
}

# need rd name here so cpue gets integrated into the original documentation
#' @rdname cpue
#' @param effort Numeric vector of effort
#' @param gear_factor Numeric adjustment for gear standard
#' @param verbose Logical indicating whether to print processing messages (default is FALSE)
#' @param method a method o "log" or "ratio"
#'
#' @returns A numeric vector of CPUE values of the class "cpue results

#' @export
#'
#' @examples
#' cpue(100, 10)
#' cpue(100, 10, gear_factor = 0.5)
cpue.numeric <- function(
    catch,
    effort,
    gear_factor = 1,
    method = c("ratio", "log"),
    verbose = getOption("fishr.verbose", FALSE)
) {
  method <- match.arg(method)

  validate_numeric_inputs(catch = catch, effort = effort)

  if (verbose) {
    message("Processing ", length(catch), " records using ", method, " method")
  }

  raw_cpue <- switch(
    method,
    ratio = catch / effort,
    log = log(catch / effort)
  )


new_cpue_result(
  raw_cpue * gear_factor,
  method = method,
  gear_factor = gear_factor,
  n_records = length(catch)
)

}

#' @rdname cpue
#' @export
cpue.data.frame <- function(catch,
                            effort,
                            gear_factor = 1,
                            method = c("ratio", "log"),
                            verbose = getOption("fishr.verbose", FALSE),
                            ...
){
  if (!"catch" %in% names(catch)) {
    stop("Column 'catch' not found in data frame.", call. = FALSE)
  }
  if (!"effort" %in% names(catch)) {
    stop("Column 'effort' not found in data frame.", call. = FALSE)
  }
  cpue(
    catch = catch$catch,
    effort = catch$effort,
    gear_factor = gear_factor,
    method = method,
    verbose = verbose
  )
}

#' @rdname cpue
#' @export
cpue.default <- function(catch, ...){
  stop("Unsupported input type for cpue():", class(catch), call. = FALSE)
}


#' @export
#has to include x and ... in the function call
print.cpue_result <- function(x, ...){
  cat("CPUE results for", length(x), " records\n")
  cat("Method: ", attr(x, "method"), "\n")
  cat("Gear factor:", attr(x, "gear_factor"), "\n")
  cat("Values: ", round(x, 2), "\n")
  invisible(x)
}

#' @export
summary.cpue_result <- function(object, ...){
  cat("Survey Result Summary\n")
  cat(" --------------------------\n")
  cat("Method:           ", attr(object, "method"), "\n")
  cat("Gear factor:      ", attr(object, "gear_factor"), "\n")
  cat("Records:          ", attr(object, "n_records"), "\n")
  cat("Mean CPUE:        ", round(mean(object), 2), "\n")
  cat("Standard Deviation: ", round(stats::sd(object), 2), "\n")
  invisible(object)
}


new_cpue_result <- function(values, method, gear_factor, n_records) {
  structure(
    values,
    method = method,
    gear_factor = gear_factor,
    n_records = n_records,
    class = "cpue_result"
  )
}
