#' @noRd
ParamCMS <- new_class("ParamCMS", class_list, package = NULL)

#' @noRd
ParamPDC <- new_class("ParamPDC", class_list, package = NULL)

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
      default = 5000L
    ),
    query = class_character,
    action = class_character,
    results = new_property(
      class_integer,
      getter = function(self) {
        flatten_url(
          paste0(self@url, "/stats?"),
          self@query %0% NULL
        ) |>
          base_request("found_rows")
      }
    )
  )
)

#' @noRd
ListCMS <- new_class(
  "ListCMS",
  API,
  package = NULL,
  properties = list(
    end = class_character,
    url = new_property(
      class_list,
      getter = function(self) URL_ListCMS(self@end)
    ),
    limit = new_property(
      class_integer,
      default = 5000L
    ),
    query = class_character,
    action = class_character,
    results = new_property(
      class_integer,
      getter = function(self) {
        flatten_url(
          paste0(self@url, "/stats?"),
          self@query %0% NULL
        ) |>
          multi_count(self@url, "found_rows")
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
      default = 1500L
    ),
    query = class_character,
    action = class_character,
    results = new_property(
      class_integer,
      getter = function(self) {
        flatten_url(
          self@url,
          self@query %0% NULL,
          opts_prov(results = "false")
        ) |>
          base_request("count")
      }
    )
  )
)

#' @noRd
build <- S7::new_generic("build", "x")

#' @noRd
execute <- S7::new_generic("execute", "x")

#' @noRd
empty <- new_generic("empty", "x")

#' @noRd
method(empty, API) <- function(x) {
  length(x@query) == 0L
}

#' @noRd
request_preview <- new_generic("request_preview", "x")

#' @noRd
req_total <- S7::new_generic("req_total", "x")

#' @noRd
req_count <- S7::new_generic("req_count", "x")

#' @noRd
req_empty <- S7::new_generic("req_empty", "x")

#' @noRd
req_single <- S7::new_generic("req_single", "x")

#' @noRd
req_multi <- S7::new_generic("req_multi", "x")

#' @noRd
req_set <- S7::new_generic("req_set", "x")
