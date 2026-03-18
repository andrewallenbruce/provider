compact_list(
  npi = npi,
  ind_pac_id = pac,
  provider_last_name = last,
  provider_first_name = first,
  provider_middle_name = middle,
  suff = suffix,
  facility_type = facility_type,
  facility_affiliations_certification_number = facility_ccn,
  facility_type_certification_number = parent_ccn
)

parameters <- S7::new_class(
  "parameters",
  properties = list(
    npi = NULL | S7::class_integer,
    ind_pac_id = NULL | S7::class_integer,
    provider_last_name = NULL | S7::class_character,
    provider_first_name = NULL | S7::class_character,
    provider_middle_name = NULL | S7::class_character,
    suff = NULL | S7::class_character,
    facility_type = S7::new_property(
      NULL | S7::class_character,
      setter = function(self, value) {
        self@facility_type <- value
        self
      },
      getter = function(self) {
        if (is.null(self@facility_type)) {
          return(NULL)
        }
        switch(
          self@facility_type,
          hp = "Hospital",
          lt = "Long-term care hospital",
          nh = "Nursing home",
          irf = "Inpatient rehabilitation facility",
          hha = "Home health agency",
          snf = "Skilled nursing facility",
          hs = "Hospice",
          df = "Dialysis facility"
        )
      }
    ),
    facility_affiliations_certification_number = NULL | S7::class_character,
    facility_type_certification_number = NULL | S7::class_character
  )
)

x <- parameters(
  facility_type = "hp",
  facility_type_certification_number = "12345"
)

x@facility_type <- "hpp"

x

parameters(
  npi = npi,
  ind_pac_id = pac,
  provider_last_name = last,
  provider_first_name = first,
  provider_middle_name = middle,
  suff = suffix,
  facility_type = facility_type,
  facility_affiliations_certification_number = facility_ccn,
  facility_type_certification_number = parent_ccn
)

# `:=` <- RS:::`:=`

library(RS)

RS::Class(
  "Parameter",

  # Fields

  npi := RS::t_int,
  ind_pac_id := RS::t_int,
  provider_last_name := RS::t_char,
  provider_first_name := RS::t_char,
  provider_middle_name := RS::t_char,
  suff := RS::t_char,
  abb := RS::t_vector,

  facility_affiliations_certification_number := RS::t_char,
  facility_type_certification_number := RS::t_char,

  # Methods
  facility_type := function(.self) {
    switch(
      .self@abb,
      hp = "Hospital",
      lt = "Long-term care hospital",
      nh = "Nursing home",
      irf = "Inpatient rehabilitation facility",
      hha = "Home health agency",
      snf = "Skilled nursing facility",
      hs = "Hospice",
      df = "Dialysis facility"
    )
  }
)

x <- Parameter(npi = 1234567890L, abb = c("hp", "lt"))
x@npi
x@facility_type()

x$set("abb", "hp")

x <- Parameter(npi = 1234567890, abb = "hp")
x <- Parameter(npi = c(1234567890L, 9876543210L), abb = c("hp", "lt"))
x@npi <- c(1234567890, 9876543210)
