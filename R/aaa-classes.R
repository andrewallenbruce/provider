#' @noRd
Modifier <- new_class(
  "Modifier",
  class_character,
  properties = list(value = class_atomic)
)

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
    count = new_property(
      class_integer,
      getter = function(self) {
        flatten_url(
          paste0(self@url, "/stats?"),
          self@query %0% NULL
        ) |>
          base_request("found_rows")
      }
    ),
    pages = new_property(
      class_integer,
      getter = function(self) {
        offset(n = self@count, limit = self@limit)
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
    idcol = class_character,
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
    count = new_property(
      class_integer,
      getter = function(self) {
        flatten_url(
          paste0(self@url, "/stats?"),
          self@query %0% NULL
        ) |>
          multi_count(self@url, "found_rows")
      }
    ),
    pages = new_property(
      class_integer,
      getter = function(self) {
        sum2(cheapr::seq_size(0L, unlist_(self@count), self@limit))
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
    count = new_property(
      class_integer,
      getter = function(self) {
        flatten_url(
          self@url,
          self@query %0% NULL,
          opts_pdc(results = "false")
        ) |>
          base_request("count")
      }
    ),
    pages = new_property(
      class_integer,
      getter = function(self) {
        offset(n = self@count, limit = self@limit)
      }
    )
  )
)
