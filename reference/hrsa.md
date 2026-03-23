# HRSA Facilities

Health Resources & Services Administration

## Usage

``` r
hrsa_items()

hrsa_layers()

hrsa_fields(facility)

hrsa_select(facility, ...)
```

## Source

[API:
HRSA](https://data.hrsa.gov/tools/web-services/registration#serviceInfo)

## Arguments

- facility:

  Facility type

- ...:

  arguments passed on to
  [`arcgislayers::arc_select()`](https://rdrr.io/pkg/arcgislayers/man/arc_select.html)

## Value

A list of endpoints.

## Details

Query modifiers are a small DSL for use in constructing query
conditions.

## Examples

``` r
hrsa_items()
#> # A data frame: 11 × 10
#>       id name      parentLayerId defaultVisibility subLayerIds minScale maxScale
#>  * <int> <chr>             <int> <lgl>             <lgl>          <int>    <int>
#>  1     0 Hospitals            -1 FALSE             NA                 0        0
#>  2     1 Critical…            -1 FALSE             NA                 0        0
#>  3     2 Federall…            -1 FALSE             NA                 0        0
#>  4     3 Rural He…            -1 FALSE             NA                 0        0
#>  5     4 Hospices             -1 FALSE             NA                 0        0
#>  6     5 Intermed…            -1 FALSE             NA                 0        0
#>  7     6 Ambulato…            -1 FALSE             NA                 0        0
#>  8     7 Skilled …            -1 FALSE             NA                 0        0
#>  9     8 Skilled …            -1 FALSE             NA                 0        0
#> 10     9 Skilled …            -1 FALSE             NA                 0        0
#> 11    10 Nursing …            -1 FALSE             NA                 0        0
#> # ℹ 3 more variables: type <chr>, geometryType <chr>,
#> #   supportsDynamicLegends <lgl>
hrsa_layers()
#> $`0`
#> <FeatureLayer>
#> Name: Hospitals
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $`1`
#> <FeatureLayer>
#> Name: Critical Access Hospitals
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $`2`
#> <FeatureLayer>
#> Name: Federally Qualified Health Centers
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $`3`
#> <FeatureLayer>
#> Name: Rural Health Clinics
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $`4`
#> <FeatureLayer>
#> Name: Hospices
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $`5`
#> <FeatureLayer>
#> Name: Intermediate Care Facility-Mentally Retarded
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $`6`
#> <FeatureLayer>
#> Name: Ambulatory Surgical Centers
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $`7`
#> <FeatureLayer>
#> Name: Skilled Nursing Facilities
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $`8`
#> <FeatureLayer>
#> Name: Skilled Nursing Facility_Dually
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $`9`
#> <FeatureLayer>
#> Name: Skilled Nursing Facility_Distinct
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $`10`
#> <FeatureLayer>
#> Name: Nursing Facilities
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
hrsa_fields("snf_all")
#> # A data frame: 19 × 5
#>    name                          type                  alias       domain length
#>  * <chr>                         <chr>                 <chr>       <lgl>   <int>
#>  1 CERTIFIED_BED_CT              esriFieldTypeInteger  CERTIFIED_… NA         NA
#>  2 CMS_PROVIDER_ADDRESS          esriFieldTypeString   CMS_PROVID… NA        150
#>  3 CMS_PROVIDER_CAT_CD           esriFieldTypeString   CMS_PROVID… NA          2
#>  4 CMS_PROVIDER_CAT_SUB_TYP_CD   esriFieldTypeString   CMS_PROVID… NA          2
#>  5 CMS_PROVIDER_CITY             esriFieldTypeString   CMS_PROVID… NA         50
#>  6 CMS_PROVIDER_NUM              esriFieldTypeString   CMS_PROVID… NA         10
#>  7 CMS_PROVIDER_ZIP_CD           esriFieldTypeString   CMS_PROVID… NA         15
#>  8 CMS_PROVIDER_CAT_DESC         esriFieldTypeString   Facility C… NA        100
#>  9 FACILITY_NM                   esriFieldTypeString   Facility N… NA        100
#> 10 CMS_PROVIDER_CAT_SUB_TYP_DESC esriFieldTypeString   Facility S… NA        100
#> 11 FAX_NUM                       esriFieldTypeString   FAX_NUM     NA         25
#> 12 MEDICAID_SNF_BED_CT           esriFieldTypeInteger  MEDICAID_S… NA         NA
#> 13 MEDICARE_MEDICAID_SNF_BED_CT  esriFieldTypeInteger  MEDICARE_M… NA         NA
#> 14 MEDICARE_SNF_BED_CT           esriFieldTypeInteger  MEDICARE_S… NA         NA
#> 15 OBJECTID                      esriFieldTypeOID      OBJECTID    NA         NA
#> 16 PHONE_NUM                     esriFieldTypeString   PHONE_NUM   NA         25
#> 17 Shape                         esriFieldTypeGeometry Shape       NA         NA
#> 18 CMS_PROVIDER_STATE_ABBR       esriFieldTypeString   State Abbr… NA          2
#> 19 TOT_BED_CT                    esriFieldTypeInteger  TOT_BED_CT  NA         NA
```
