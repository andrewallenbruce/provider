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
s3_affiliations <- S7::new_S3_class("affiliations")
#' @noRd
s3_clia <- S7::new_S3_class("clia")
#' @noRd
s3_clinicians <- S7::new_S3_class("clinicians")
#' @noRd
s3_dialysis <- S7::new_S3_class("dialysis")
#' @noRd
s3_facility <- S7::new_S3_class("facility")
#' @noRd
s3_hospitals <- S7::new_S3_class("hospitals")
#' @noRd
s3_hospitals2 <- S7::new_S3_class("hospitals2")
#' @noRd
s3_opt_out <- S7::new_S3_class("opt_out")
#' @noRd
s3_order_refer <- S7::new_S3_class("order_refer")
#' @noRd
s3_owner <- S7::new_S3_class("owner")
#' @noRd
s3_pending <- S7::new_S3_class("pending")
#' @noRd
s3_providers <- S7::new_S3_class("providers")
#' @noRd
s3_quality <- S7::new_S3_class("quality")
#' @noRd
s3_reassignments <- S7::new_S3_class("reassignments")
#' @noRd
s3_revocations <- S7::new_S3_class("revocations")
#' @noRd
s3_transparency <- S7::new_S3_class("transparency")
#' @noRd
s3_utilization <- S7::new_S3_class("utilization")
