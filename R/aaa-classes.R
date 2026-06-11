#' @noRd
ParamCMS <- S7::new_class("ParamCMS", S7::class_list, package = NULL)

#' @noRd
ParamPDC <- S7::new_class("ParamPDC", S7::class_list, package = NULL)

#' @noRd
Query <- S7::new_class("Query", S7::class_list, package = NULL)

#' @noRd
QueryCMS <- S7::new_class("QueryCMS", Query, package = NULL)

#' @noRd
QueryPDC <- S7::new_class("QueryPDC", Query, package = NULL)

#' @noRd
Endpoint <- S7::new_class(
  "Endpoint",
  package = NULL,
  properties = list(
    end = S7::class_character,
    url = S7::class_character | S7::class_list,
    query = S7::class_character,
    length = S7::new_property(
      S7::class_integer,
      getter = function(self) nchar(self@query)
    ),
    action = S7::class_character,
    count = S7::new_property(S7::class_integer, default = 0L),
    pages = S7::new_property(
      S7::class_integer,
      getter = function(self) {
        if (self@count == 0L) {
          return(0L)
        }
        offset(self@count, self@limit)
      }
    )
  )
)

#' @noRd
EndpointCMS <- S7::new_class(
  "EndpointCMS",
  Endpoint,
  package = NULL,
  properties = list(
    limit = S7::new_property(
      S7::class_integer,
      getter = function(self) 5000L
    )
  )
)

#' @noRd
EndpointCMSList <- S7::new_class(
  "EndpointCMSList",
  EndpointCMS,
  package = NULL,
  properties = list(
    pages = S7::new_property(
      S7::class_integer,
      getter = function(self) {
        x <- unlist_(self@count)
        if (collapse::allv(x, 0L)) {
          return(0L)
        }
        x <- x[collapse::whichv(x, 0L, invert = TRUE)]
        sum2(cheapr::seq_size(0L, x, self@limit))
      }
    )
  )
)

#' @noRd
EndpointPDC <- S7::new_class(
  "EndpointPDC",
  Endpoint,
  package = NULL,
  properties = list(
    limit = S7::new_property(
      S7::class_integer,
      getter = function(self) 1500L
    )
  )
)

#' @noRd
request_count <- S7::new_generic("request_count", "x")

#' @noRd
request_preview <- S7::new_generic("request_preview", "x")

#' @noRd
request_single <- S7::new_generic("request_single", "x")

#' @noRd
request_multi <- S7::new_generic("request_multi", "x")

#' @noRd
execute <- S7::new_generic("execute", "x")

#' @noRd
S7::method(execute, Endpoint) <- function(x) {
  check_online()

  if (length(x@query) == 0L) {
    switch(
      x@action,
      count = return(report_total(x)),
      set = return(request_multi(x)),
      return(request_preview(x))
    )
  }

  if (x@pages == 0L || x@action == "count") {
    report_count(x)
    return(x@count)
  }

  if (x@pages == 1L) {
    return(request_single(x))
  }
  request_multi(x)
}

#' @noRd
S7::method(execute, EndpointCMSList) <- function(x) {
  check_online()

  if (length(x@query) == 0L) {
    switch(
      x@action,
      count = return(report_total(x)),
      set = return(request_multi(x)),
      return(request_preview(x))
    )
  }

  if (x@pages == 0L || x@action == "count") {
    report_count(x)
    return(x@count)
  }

  if (x@pages <= length(x@url)) {
    return(request_single(x))
  }
  request_multi(x)
}
