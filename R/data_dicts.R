#' #' provider_enrollment data dictionary
#' #' @autoglobal
#' #' @noRd
#' provider_enrollment_data_dict <- function() {
#'
#'   tibble::tibble(
#'     Variable = c(
#'     "`npi`",
#'     "`pac_id`",
#'     "`enroll_id`",
#'     "`specialty_cd`",
#'     "`specialty_desc`",
#'     "`state`",
#'     "`first_name`",
#'     "`middle_name`",
#'     "`last_name`",
#'     "`gender`"),
#'
#'   Description = c(
#'     "National Provider Identifier",
#'     "PECOS Associate Control ID",
#'     "Enrollment ID",
#'     "Provider Type Code",
#'     "Provider Type Description",
#'     "State Code",
#'     "First Name",
#'     "Middle Name",
#'     "Last Name",
#'     "Gender"),
#'
#'   Definition = c(
#'     "An NPI is a 10-digit unique numeric identifier that all providers must obtain before enrolling in Medicare. It is assigned to health care providers upon application through the National Plan and Provider Enumeration System (NPPES).",
#'     "Provider associate level variable (PAC ID) from PECOS database used to link across tables. A PAC ID is a 10-digit unique numeric identifier that is assigned to each individual or organization in PECOS. All entity-level information (e.g., tax identification numbers and organizational names) is linked through the PAC ID. A PAC ID may be associated with multiple Enrollment IDs if the individual or organization enrolled multiple times under different circumstances.",
#'     "Provider enrollment ID from PECOS database used to link across tables. An Enrollment ID is a 15-digit unique alphanumeric identifier that is assigned to each new provider enrollment application. All enrollment-level information (e.g., enrollment type, enrollment state, provider specialty and reassignment of benefits) is linked through the Enrollment ID.",
#'     "Provider enrollment application and enrollment specialty type. This field shows the provider’s primary specialty code. For practitioners and DME suppliers, please see the Secondary Specialty file for a list of secondary specialties (when applicable). Only about 20% of practitioners and DME suppliers have at least one secondary specialty.",
#'     "Provider enrollment application and enrollment specialty type description, see PROVIDER_TYPE_CD - Reference for description of values.",
#'     "Provider enrollment state, abbreviated location. Providers enroll at the state level, so one PAC ID may be associated with multiple ENRLMT_IDs and multiple STATE_CD values.",
#'     "Individual provider first name.",
#'     "Individual provider middle name.",
#'     "Individual provider last name.",
#'     "Individual provider gender.")) |>
#'     provider:::gt_datadict()
#'
#' }
#'
#' #' provider_enrollment_type_code_list
#' #' @autoglobal
#' #' @noRd
#' provider_enrollment_type_code_list <- function() {
#'
#'   tibble::tibble(
#'     Code = c(
#'       "`00-00`", "`00-01`", "`00-02`", "`00-03`", "`00-04`", "`00-05`",
#'       "`00-06`", "`00-07`", "`00-08`", "`00-09`", "`00-10`", "`00-13`",
#'       "`00-14`", "`00-17`", "`00-18`", "`00-19`", "`00-85`", "`12-23`",
#'       "`12-31`", "`12-45`", "`12-47`", "`12-49`", "`12-59`", "`12-60`",
#'       "`12-61`", "`12-63`", "`12-65`", "`12-69`", "`12-70`", "`12-73`",
#'       "`12-74`", "`12-75`", "`12-87`", "`12-C0`", "`12-C1`", "`12-Z1`",
#'       "`12-Z3`", "`12-Z4`", "`12-Z5`", "`14-01`", "`14-02`", "`14-03`",
#'       "`14-04`", "`14-05`", "`14-06`", "`14-07`", "`14-08`", "`14-09`",
#'       "`14-10`", "`14-11`", "`14-12`", "`14-13`", "`14-14`", "`14-15`",
#'       "`14-16`", "`14-17`", "`14-18`", "`14-19`", "`14-20`", "`14-21`",
#'       "`14-22`", "`14-23`", "`14-24`", "`14-25`", "`14-26`", "`14-27`",
#'       "`14-28`", "`14-29`", "`14-30`", "`14-32`", "`14-33`", "`14-34`",
#'       "`14-35`", "`14-36`", "`14-37`", "`14-38`", "`14-39`", "`14-40`",
#'       "`14-41`", "`14-42`", "`14-43`", "`14-44`", "`14-46`", "`14-48`",
#'       "`14-50`", "`14-62`", "`14-64`", "`14-65`", "`14-66`", "`14-67`",
#'       "`14-68`", "`14-70`", "`14-71`", "`14-72`", "`14-73`", "`14-76`",
#'       "`14-77`", "`14-78`", "`14-79`", "`14-80`", "`14-81`", "`14-82`",
#'       "`14-83`", "`14-84`", "`14-85`", "`14-86`", "`14-88`", "`14-89`",
#'       "`14-90`", "`14-91`", "`14-92`", "`14-93`", "`14-94`", "`14-97`",
#'       "`14-98`", "`14-99`", "`14-99`", "`14-C0`", "`14-C3`", "`30-01`",
#'       "`30-02`", "`30-03`", "`30-04`", "`30-05`", "`30-06`", "`30-07`",
#'       "`30-08`", "`30-11`", "`30-12`", "`30-13`", "`30-14`", "`30-16`",
#'       "`30-18`", "`30-19`", "`30-20`", "`30-23`", "`30-24`", "`30-25`",
#'       "`30-26`", "`30-29`", "`30-30`", "`30-34`", "`30-35`", "`30-37`",
#'       "`30-38`", "`30-40`", "`30-41`", "`30-44`", "`30-46`", "`30-48`",
#'       "`30-49`", "`30-50`", "`30-51`", "`30-52`", "`30-53`", "`30-54`",
#'       "`30-55`", "`30-56`", "`30-57`", "`30-58`", "`30-59`", "`30-61`",
#'       "`30-63`", "`30-64`", "`30-65`", "`30-66`", "`30-67`", "`30-70`",
#'       "`30-72`", "`30-76`", "`30-77`", "`30-79`", "`30-82`", "`30-83`",
#'       "`30-84`", "`30-85`", "`30-87`", "`30-88`", "`30-89`", "`30-90`",
#'       "`30-91`", "`30-92`", "`30-93`", "`30-94`", "`30-95`", "`30-96`",
#'       "`30-97`", "`30-99`", "`30-A0`", "`30-A1`", "`30-A2`", "`30-A3`",
#'       "`30-A4`", "`30-A5`", "`30-A6`", "`30-A7`", "`30-A8`", "`30-A9`",
#'       "`30-B1`", "`30-B2`", "`30-B3`", "`30-B4`", "`30-B5`", "`30-C0`",
#'       "`33-01`", "`33-02`", "`33-03`", "`33-04`", "`33-05`", "`33-06`",
#'       "`33-07`", "`33-08`", "`33-09`", "`33-10`", "`33-11`", "`33-12`",
#'       "`33-13`", "`33-14`", "`33-16`", "`33-17`", "`33-18`", "`33-19`",
#'       "`33-20`", "`33-21`", "`33-22`", "`33-23`", "`33-24`", "`33-25`",
#'       "`33-26`", "`33-27`", "`33-28`", "`33-29`", "`33-30`", "`33-33`",
#'       "`33-34`", "`33-35`", "`33-36`", "`33-37`", "`33-38`", "`33-39`",
#'       "`33-40`", "`33-41`", "`33-42`", "`33-43`", "`33-44`", "`33-46`",
#'       "`33-48`", "`33-50`", "`33-62`", "`33-66`", "`33-68`", "`33-71`",
#'       "`33-72`", "`33-76`", "`33-77`", "`33-78`", "`33-79`", "`33-80`",
#'       "`33-81`", "`33-82`", "`33-83`", "`33-84`", "`33-85`", "`33-86`",
#'       "`33-88`", "`33-89`", "`33-90`", "`33-91`", "`33-92`", "`33-93`",
#'       "`33-94`", "`33-97`", "`33-98`", "`33-99`", "`33-C0`", "`33-C3`",
#'       "`53-D1`"
#'     ),
#'     Type = c(
#'       "Part A Provider", "Part A Provider", "Part A Provider", "Part A Provider",
#'       "Part A Provider", "Part A Provider", "Part A Provider", "Part A Provider",
#'       "Part A Provider", "Part A Provider", "Part A Provider", "Part A Provider",
#'       "Part A Provider", "Part A Provider", "Part A Provider", "Part A Provider",
#'       "Part A Provider", "Part B Supplier", "Part B Supplier", "Part B Supplier",
#'       "Part B Supplier", "Part B Supplier", "Part B Supplier", "Part B Supplier",
#'       "Part B Supplier", "Part B Supplier", "Part B Supplier", "Part B Supplier",
#'       "Part B Supplier", "Part B Supplier", "Part B Supplier", "Part B Supplier",
#'       "Part B Supplier", "Part B Supplier", "Part B Supplier", "Part B Supplier",
#'       "Part B Supplier", "Part B Supplier", "Part B Supplier", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "Practitioner",
#'       "Practitioner", "Practitioner", "Practitioner", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "DME Supplier", "DME Supplier", "DME Supplier", "DME Supplier",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "Order And Referring Only", "Order And Referring Only", "Order And Referring Only",
#'       "MDPP Supplier"
#'     ),
#'     Subtype = c(
#'       "Religious Non-Medical Health Care Institution (RNHCI)", "Community Mental Health Center",
#'       "Comprehensive Outpatient Rehabilitation Facility", "End-Stage Renal Disease Facility (Esrd)",
#'       "Federally Qualified Health Center (FQHC)", "Histocompatibility Laboratory",
#'       "Home Health Agency", "Home Health Agency (Subunit)", "Hospice",
#'       "Hospital", "Indian Health Services Facility", "Organ Procurement Organization (OPO)",
#'       "Outpatient Physical Therapy/Occupational Therapy/Speech Pathology Services",
#'       "Rural Health Clinic", "Skilled Nursing Facility", "Other", "Critical Access Hospital",
#'       "Sports Medicine", "Intensive Cardiac Rehabilitation", "Mammography Screening Center",
#'       "Independent Diagnostic Testing Facility (IDTF)", "Ambulatory Surgical Center",
#'       "Ambulance Service Supplier", "Public Health/Welfare Agency",
#'       "Voluntary Health/Charity Agency", "Portable X-Ray Supplier",
#'       "Physical/Occupational Therapy Group In Private Practice", "Independent Clinical Laboratories (CLIA)",
#'       "Clinic/Group Practice", "Mass Immunization (Roster Biller Only)",
#'       "Radiation Therapy Center", "Slide Preparation Facilities", "Other",
#'       "Sleep Laboratory/Medicine", "Centralized Flu Biller", "Hospital Department(s)",
#'       "Medicare + Choice Organization", "Medical Faculty Practice Plan",
#'       "Other Medical Care Group", "General Practice", "General Surgery",
#'       "Allergy/Immunology", "Otolaryngology", "Anesthesiology", "Cardiovascular Disease (Cardiology)",
#'       "Dermatology", "Family Practice", "Interventional Pain Management",
#'       "Gastroenterology", "Internal Medicine", "Osteopathic Manipulative Medicine",
#'       "Neurology", "Neurosurgery", "Speech Language Pathologist", "Obstetrics/Gynecology",
#'       "Hospice/Palliative Care", "Ophthalmology", "Oral Surgery (Dentist Only)",
#'       "Orthopedic Surgery", "Cardiac Electrophysiology", "Pathology",
#'       "Sports Medicine", "Plastic And Reconstructive Surgery", "Physical Medicine And Rehabilitation",
#'       "Psychiatry", "Geriatric Psychiatry", "Colorectal Surgery (Proctology)",
#'       "Pulmonary Disease", "Diagnostic Radiology", "Anesthesiology Assistant",
#'       "Thoracic Surgery", "Urology", "Chiropractic", "Nuclear Medicine",
#'       "Pediatric Medicine", "Geriatric Medicine", "Nephrology", "Hand Surgery",
#'       "Optometry", "Certified Nurse Midwife", "Certified Registered Nurse Anesthetist",
#'       "Infectious Disease", "Endocrinology", "Podiatry", "Nurse Practitioner",
#'       "Psychologist Billing Independently", "Audiologist", "Physical Therapist",
#'       "Rheumatology", "Occupational Therapist", "Clinical Psychologist",
#'       "Single Or Multispecialty Clinic Or Group Practice", "Registered Dietitian Or Nutrition Professional",
#'       "Pain Management", "Mass Immunization Roster Biller", "Peripheral Vascular Disease",
#'       "Vascular Surgery", "Cardiac Surgery", "Addiction Medicine",
#'       "Clinical Social Worker", "Critical Care (Intensivists)", "Hematology",
#'       "Hematology/Oncology", "Preventative Medicine", "Maxillofacial Surgery",
#'       "Neuropsychiatry", "Other (Non-Physician)", "Clinical Nurse Specialist",
#'       "Medical Oncology", "Surgical Oncology", "Radiation Oncology",
#'       "Emergency Medicine", "Interventional Radiology", "Physician Assistant",
#'       "Gynecological Oncology", "Other (Physician)", "Other", "Sleep Laboratory/Medicine",
#'       "Interventional Cardiology", "Physician - General Practice",
#'       "Physician - General Surgery", "Physician - Allergy/Immunology",
#'       "Physician - Otolaryngology", "Physician - Anesthesiology", "Physician - Cardiology",
#'       "Physician - Dermatology", "Physician - Family Practice", "Physician - Internal Medicine",
#'       "Physician - Osteopathic Manipulative Medicine", "Physician - Neurology",
#'       "Physician - Neurosurgery", "Physician - Obstetrics/Gynecology",
#'       "Physician - Ophthalmology", "Oral Surgery - Dentist", "Physician - Orthopedic/Orthopedic Surgery",
#'       "Sports Medicine", "Physician - Plastic And Reconstructive Surgery",
#'       "Physician - Physical And Rehabilitation", "Physician - Psychiatry",
#'       "Physician - Pulmonary Disease", "Physician - Diagnostic Radiology",
#'       "Physician - Urology", "Physician - Chiropractic", "Physician - Pediatric Medicine",
#'       "Physician - Geriatric Medicine", "Physician - Hand Surgery",
#'       "Physician - Optometrist", "Physician - Infectious Disease",
#'       "Physician - Endocrinology", "Physician - Podiatry", "Ambulatory Surgical Center",
#'       "Nurse Practitioner", "Medical Supply Company With Orthotic Personnel",
#'       "Medical Supply Company With Prosthetic Personnel", "Medical Supply Company With Orthotic-Prosthetic",
#'       "Medical Supply Company", "Orthotic Personnel", "Prosthetic Personnel",
#'       "Certified Orth/Pros/Pedorthist", "Medical Supply Company With Registered Pharmacist",
#'       "Ambulance Service Supplier", "Voluntary Health Or Charitable Agencies",
#'       "Portable X-Ray Supplier", "Independently-Billing Audiologist",
#'       "Independently-Practicing Physical Therapist", "Physician - Rheumatology",
#'       "Independently-Practicing Occupational Therapist", "Multi-Specialty - Physician",
#'       "Physician - Interventional Pain Management", "Physician - Peripheral Vascular Disease",
#'       "Physician - Vascular Surgery", "Physician - Addiction Medicine",
#'       "Physician - Hematology", "Physician - Hematology/Oncology",
#'       "Physician - Preventive Medicine", "Physician - Maxillofacial Surgery",
#'       "Other", "Unknown Supplier/Provider", "Certified Clinical Nurse Specialist",
#'       "Physician - Medical Oncology", "Physician - Surgical Oncology",
#'       "Physician - Radiation Oncology", "Physician - Emergency Medicine",
#'       "Physician - Interventional Radiology", "Independent Physiological Lab",
#'       "Optician", "Physician Assistant", "Physician - Unknown Physician Specialty",
#'       "Hospital", "Nursing Facility", "Nursing Facility Intermediate Care",
#'       "Skilled Nursing Facility Other", "Home Health Agency", "Pharmacy",
#'       "Medical Supply Company With Respiratory Therapist", "Department Store",
#'       "Grocery Store", "Indian Health Service Or Tribal Facility",
#'       "Oxygen & Equipment", "Pedorthic Personnel", "Medical Supply Company With Pedorthic Personnel",
#'       "Rehabilitation Agency", "Ocularist", "Sleep Laboratory/Medicine",
#'       "General Practice", "General Surgery", "Allergy/Immunology",
#'       "Otolaryngology", "Anesthesiology", "Cardiovascular Disease (Cardiology)",
#'       "Dermatology", "Family Practice", "Interventional Pain Management",
#'       "Gastroenterology", "Internal Medicine", "Osteopathic Manipulative Medicine",
#'       "Neurology", "Neurosurgery", "Obstetrics/Gynecology", "Hospice/Palliative Care",
#'       "Ophthalmology", "Oral Surgery (Dentist Only)", "Orthopedic Surgery",
#'       "Cardiac Electrophysiology", "Pathology", "Sports Medicine",
#'       "Plastic And Reconstructive Surgery", "Physical Medicine And Rehabilitation",
#'       "Psychiatry", "Geriatric Psychiatry", "Colorectal Surgery (Proctology)",
#'       "Pulmonary Disease", "Diagnostic Radiology", "Thoracic Surgery",
#'       "Urology", "Chiropractic", "Nuclear Medicine", "Pediatric Medicine",
#'       "Geriatric Medicine", "Nephrology", "Hand Surgery", "Optometry",
#'       "Certified Nurse Midwife", "Certified Registered Nurse Anesthetist",
#'       "Infectious Disease", "Endocrinology", "Podiatry", "Nurse Practitioner",
#'       "Psychologist Billing Independently", "Rheumatology", "Clinical Psychologist",
#'       "Registered Dietitian Or Nutrition Professional", "Pain Management",
#'       "Peripheral Vascular Disease", "Vascular Surgery", "Cardiac Surgery",
#'       "Addiction Medicine", "Clinical Social Worker", "Critical Care (Intensivists)",
#'       "Hematology", "Hematology/Oncology", "Preventative Medicine",
#'       "Maxillofacial Surgery", "Neuropsychiatry", "Other (Non-Physician)",
#'       "Clinical Nurse Specialist", "Medical Oncology", "Surgical Oncology",
#'       "Radiation Oncology", "Emergency Medicine", "Interventional Radiology",
#'       "Physician Assistant", "Gynecological Oncology", "Other (Physician)",
#'       "Sleep Laboratory/Medicine", "Interventional Cardiology", "In-Person MDPP Supplier"
#'     )) |>
#'     gt::gt() |>
#'     gt::fmt_markdown(columns = Code) |>
#'     gtExtras::gt_theme_nytimes() |>
#'     gtExtras::gt_merge_stack(col1 = Type,
#'                              col2 = Subtype,
#'                              small_cap = FALSE,
#'                              font_size = c("16px", "14px"),
#'                              font_weight = c("bold", "normal"),
#'                              palette = c("black", "darkgray")) |>
#'     gt::opt_stylize(style = 6,
#'                     color = "red",
#'                     add_row_striping = FALSE) |>
#'     gt::opt_table_lines(extent = "default") |>
#'     gt::opt_table_outline(style = "none") |>
#'     gt::opt_table_font(font = gt::google_font(name = "Karla")) |>
#'     gt::tab_options(table.width = gt::pct(100))
#'
#' }
#'
#' #' readme function table
#' #' @autoglobal
#' #' @noRd
#' function_tbl    <- function() {
#'   qpp_func    <- gluedown::md_code("quality_payment()")
#'   qpp_link    <- gluedown::md_link(
#'     "CMS Quality Payment Program" = "https://data.cms.gov/quality-of-care/quality-payment-program-experience")
#'   nppes_func    <- gluedown::md_code("nppes_npi()")
#'   nppes_link    <- gluedown::md_link(
#'     "NPPES National Provider Identifier (NPI) Registry" = "https://npiregistry.cms.hhs.gov/search")
#'   open_func     <- gluedown::md_code("open_payments()")
#'   open_link     <- gluedown::md_link(
#'     "CMS Open Payments Program" = "https://openpaymentsdata.cms.gov/dataset/0380bbeb-aea1-58b6-b708-829f92a48202")
#'   mppe_func     <- gluedown::md_code("provider_enrollment()")
#'   mppe_link     <- gluedown::md_link(
#'     "Medicare Fee-For-Service Public Provider Enrollment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-fee-for-service-public-provider-enrollment")
#'   mme_func      <- gluedown::md_code("beneficiary_enrollment()")
#'   mme_link      <- gluedown::md_link(
#'     "Medicare Monthly Enrollment" = "https://data.cms.gov/summary-statistics-on-beneficiary-enrollment/medicare-and-medicaid-reports/medicare-monthly-enrollment")
#'   miss_func     <- gluedown::md_code("missing_information()")
#'   miss_link     <- gluedown::md_link(
#'     "CMS Public Reporting of Missing Digital Contact Information" = "https://data.cms.gov/provider-compliance/public-reporting-of-missing-digital-contact-information")
#'   order_func    <- gluedown::md_code("order_refer()")
#'   order_link    <- gluedown::md_link(
#'     "Medicare Order and Referring" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/order-and-referring")
#'   opt_func      <- gluedown::md_code("opt_out()")
#'   opt_link      <- gluedown::md_link(
#'     "Medicare Opt Out Affidavits" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/opt-out-affidavits")
#'   pbp_func      <- gluedown::md_code("physician_by_provider()")
#'   pbp_link      <- gluedown::md_link(
#'     "Medicare Physician & Other Practitioners: by Provider" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider")
#'   pbs_func      <- gluedown::md_code("physician_by_service()")
#'   pbs_link      <- gluedown::md_link(
#'     "Medicare Physician & Other Practitioners: by Provider and Service" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-provider-and-service")
#'   pbg_func      <- gluedown::md_code("physician_by_geography()")
#'   pbg_link      <- gluedown::md_link(
#'     "Medicare Physician & Other Practitioners: by Geography and Service" = "https://data.cms.gov/provider-summary-by-type-of-service/medicare-physician-other-practitioners/medicare-physician-other-practitioners-by-geography-and-service")
#'   redd_func     <- gluedown::md_code("revalidation_date()")
#'   redd_link     <- gluedown::md_link(
#'     "Medicare Revalidation Due Date" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-due-date-list")
#'   rere_func     <- gluedown::md_code("revalidation_reassign()")
#'   rere_link     <- gluedown::md_link(
#'     "Medicare Revalidation Reassignment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-reassignment-list")
#'   recl_func     <- gluedown::md_code("revalidation_group()")
#'   recl_link     <- gluedown::md_link(
#'     "Medicare Revalidation Clinic Group Practice Reassignment" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/revalidation-clinic-group-practice-reassignment")
#'   ccs_func      <- gluedown::md_code("cc_specific()")
#'   ccs_link      <- gluedown::md_link(
#'     "Medicare Specific Chronic Conditions" = "https://data.cms.gov/medicare-chronic-conditions/specific-chronic-conditions")
#'   ccm_func      <- gluedown::md_code("cc_multiple()")
#'   ccm_link      <- gluedown::md_link(
#'     "Medicare Multiple Chronic Conditions" = "https://data.cms.gov/medicare-chronic-conditions/multiple-chronic-conditions")
#'   clia_func     <- gluedown::md_code("clia_labs()")
#'   clia_link     <- gluedown::md_link(
#'     "Medicare Provider of Services File - Clinical Laboratories" = "https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/provider-of-services-file-clinical-laboratories")
#'   tax_func      <- gluedown::md_code("taxonomy_crosswalk()")
#'   tax_link      <- gluedown::md_link(
#'     "Medicare Provider and Supplier Taxonomy Crosswalk" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/medicare-provider-and-supplier-taxonomy-crosswalk")
#'   pend_func     <- gluedown::md_code("pending_applications()")
#'   pend_link     <- gluedown::md_link(
#'     "Medicare Pending Initial Logging and Tracking" = "https://data.cms.gov/provider-characteristics/medicare-provider-supplier-enrollment/pending-initial-logging-and-tracking-physicians")
#'   affil_func    <- gluedown::md_code("facility_affiliations()")
#'   affil_link    <- gluedown::md_link(
#'     "CMS Physician Facility Affiliations" = "https://data.cms.gov/provider-data/dataset/27ea-46a8")
#'   drclin_func   <- gluedown::md_code("doctors_and_clinicians()")
#'   drclin_link   <- gluedown::md_link(
#'     "Doctors and Clinicians National Downloadable File" = "https://data.cms.gov/provider-data/dataset/mj5m-pzi6")
#'   addph_func   <- gluedown::md_code("addl_phone_numbers()")
#'   addph_link   <- gluedown::md_link(
#'     "Physician Additional Phone Numbers" = "https://data.cms.gov/provider-data/dataset/phys-phon")
#'   hspen_func   <- gluedown::md_code("hospital_enrollment()")
#'   hspen_link   <- gluedown::md_link(
#'     "Hospital Enrollments" = "https://data.cms.gov/provider-characteristics/hospitals-and-other-facilities/hospital-enrollments")
#'
#'   func_tbl <- data.frame(Function = c(nppes_func,
#'                                       open_func,
#'                                       mppe_func,
#'                                       mme_func,
#'                                       order_func,
#'                                       opt_func,
#'                                       pbp_func,
#'                                       pbs_func,
#'                                       pbg_func,
#'                                       redd_func,
#'                                       recl_func,
#'                                       rere_func,
#'                                       ccs_func,
#'                                       ccm_func,
#'                                       #clia_func,
#'                                       tax_func,
#'                                       miss_func,
#'                                       pend_func,
#'                                       affil_func,
#'                                       drclin_func,
#'                                       #addph_func,
#'                                       hspen_func,
#'                                       qpp_func
#'   ),
#'   API      = c(nppes_link,
#'                open_link,
#'                mppe_link,
#'                mme_link,
#'                order_link,
#'                opt_link,
#'                pbp_link,
#'                pbs_link,
#'                pbg_link,
#'                redd_link,
#'                recl_link,
#'                rere_link,
#'                ccs_link,
#'                ccm_link,
#'                #clia_link,
#'                tax_link,
#'                miss_link,
#'                pend_link,
#'                affil_link,
#'                drclin_link,
#'                #addph_link,
#'                hspen_link,
#'                qpp_link
#'   ))
#'
#'   return(func_tbl)
#' }
