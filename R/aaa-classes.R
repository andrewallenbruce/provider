#' @noRd
ParamCMS <- S7::new_class("ParamCMS", S7::class_list, package = NULL)

#' @noRd
ParamPDC <- S7::new_class("ParamPDC", S7::class_list, package = NULL)

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
s3_nursing <- S7::new_S3_class("nursing")
#' @noRd
#' @noRd
s3_supplier <- S7::new_S3_class("supplier")
#' @noRd
s3_long_term <- S7::new_S3_class("long_term")
#' @noRd
s3_ambulatory <- S7::new_S3_class("ambulatory")
#' @noRd
s3_affiliations <- S7::new_S3_class("affiliations")
#' @noRd
s3_clia <- S7::new_S3_class("clia")
#' @noRd
s3_clinician <- S7::new_S3_class("clinician")
#' @noRd
s3_dialysis <- S7::new_S3_class("dialysis")
#' @noRd
s3_facility <- S7::new_S3_class("facility")
#' @noRd
s3_hospital <- S7::new_S3_class("hospital")
#' @noRd
s3_hospital2 <- S7::new_S3_class("hospital2")
#' @noRd
s3_nppes <- S7::new_S3_class("nppes")
#' @noRd
s3_opted_out <- S7::new_S3_class("opted_out")
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
s3_reassigned <- S7::new_S3_class("reassigned")
#' @noRd
s3_revoked <- S7::new_S3_class("revoked")
#' @noRd
s3_transparency <- S7::new_S3_class("transparency")
#' @noRd
s3_utilization <- S7::new_S3_class("utilization")
#' @noRd
s3_services <- S7::new_S3_class("services")
#' @noRd
s3_geography <- S7::new_S3_class("geography")
#' @noRd
s3_inpatient <- S7::new_S3_class("inpatient")
#' @noRd
s3_outpatient <- S7::new_S3_class("outpatient")
