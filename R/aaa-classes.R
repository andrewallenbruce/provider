#' @noRd
Modifier <- new_class(
  "Modifier",
  class_character,
  package = NULL,
  properties = list(
    operator = class_character,
    value = class_atomic
  )
)

#' @noRd
ParamCMS <- new_class("ParamCMS", class_list, package = NULL)

#' @noRd
ParamPDC <- new_class("ParamPDC", class_list, package = NULL)

#' @noRd
Query <- new_class("Query", class_list, package = NULL)

#' @noRd
QueryCMS <- new_class("QueryCMS", Query, package = NULL)

#' @noRd
QueryPDC <- new_class("QueryPDC", Query, package = NULL)

#' @noRd
API <- new_class("API", package = NULL, abstract = TRUE)

#' @noRd
CMS <- new_class(
  "CMS",
  API,
  package = NULL,
  properties = list(
    end = class_character,
    url = new_property(
      class_character,
      getter = function(self) URL_CMS(self@end)
    ),
    limit = new_property(
      class_integer,
      getter = function(self) 5000L
    ),
    query = class_character,
    length = new_property(
      class_integer,
      getter = function(self) nchar(self@query)
    ),
    action = class_character,
    count = new_property(
      class_integer,
      getter = function(self) {
        flatten_cms(
          self@url,
          self@query,
          append = "/stats?"
        ) |>
          base_request("found_rows")
      }
    ),
    pages = new_property(
      class_integer,
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
CMSList <- new_class(
  "CMSList",
  CMS,
  package = NULL,
  properties = list(
    url = new_property(
      class_list,
      getter = function(self) URL_CMS_List(self@end)
    ),
    count = new_property(
      class_integer,
      getter = function(self) {
        flatten_cms(
          self@url,
          self@query,
          append = "/stats?"
        ) |>
          multi_count(
            self@url,
            "found_rows"
          )
      }
    ),
    pages = new_property(
      class_integer,
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
PDC <- new_class(
  "PDC",
  API,
  package = NULL,
  properties = list(
    end = class_character,
    url = new_property(
      class_character,
      getter = function(self) URL_PDC(self@end)
    ),
    limit = new_property(
      class_integer,
      getter = function(self) 1500L
    ),
    query = class_character,
    length = new_property(
      class_integer,
      getter = function(self) nchar(self@query)
    ),
    action = class_character,
    count = new_property(
      class_integer,
      getter = function(self) {
        flatten_pdc(
          self@url,
          self@query,
          results = "false"
        ) |>
          base_request("count")
      }
    ),
    pages = new_property(
      class_integer,
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
build <- new_generic("build", "x")

#' @noRd
execute <- new_generic("execute", "x")

#' @noRd
request_preview <- new_generic("request_preview", "x")

#' @noRd
request_single <- new_generic("request_single", "x")

#' @noRd
request_multi <- new_generic("request_multi", "x")

#' @noRd
method(execute, API) <- function(x) {
  check_online()

  if (length(x@query) == 0L) {
    report_total(x)

    switch(
      x@action,
      count = return(x@count),
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
method(execute, CMSList) <- function(x) {
  check_online()

  if (length(x@query) == 0L) {
    report_total(x)

    switch(
      x@action,
      count = return(x@count),
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
