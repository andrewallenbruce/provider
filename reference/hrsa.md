# HRSA Facilities

HRSA Facilities

## Usage

``` r
hrsa_open()

hrsa_layers(ms)

hrsa_items(ms)

hrsa_fields(facility, fl)

hrsa_select(facility, fl)
```

## Arguments

- ms:

  `<MapServer>` String indicating what to retrieve.

- facility:

  Facility type

- fl:

  `<FeatureLayer>`

## Value

A list of endpoints.

## Examples

``` r
(MS <- hrsa_open())
#> <MapServer <11 layers, 0 tables>>
#> CRS: 3857
#> Capabilities: Map,Query,Data
#>   0: Hospitals (esriGeometryPoint)
#>   1: Critical Access Hospitals (esriGeometryPoint)
#>   2: Federally Qualified Health Centers (esriGeometryPoint)
#>   3: Rural Health Clinics (esriGeometryPoint)
#>   4: Hospices (esriGeometryPoint)
#>   5: Intermediate Care Facility-Mentally Retarded (esriGeometryPoint)
#>   6: Ambulatory Surgical Centers (esriGeometryPoint)
#>   7: Skilled Nursing Facilities (esriGeometryPoint)
#>   8: Skilled Nursing Facility_Dually (esriGeometryPoint)
#>   9: Skilled Nursing Facility_Distinct (esriGeometryPoint)
#>   10: Nursing Facilities (esriGeometryPoint)
hrsa_items(MS)
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
(FL <- hrsa_layers(MS))
#> $layers
#> $layers$`0`
#> <FeatureLayer>
#> Name: Hospitals
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $layers$`1`
#> <FeatureLayer>
#> Name: Critical Access Hospitals
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $layers$`2`
#> <FeatureLayer>
#> Name: Federally Qualified Health Centers
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $layers$`3`
#> <FeatureLayer>
#> Name: Rural Health Clinics
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $layers$`4`
#> <FeatureLayer>
#> Name: Hospices
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $layers$`5`
#> <FeatureLayer>
#> Name: Intermediate Care Facility-Mentally Retarded
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $layers$`6`
#> <FeatureLayer>
#> Name: Ambulatory Surgical Centers
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $layers$`7`
#> <FeatureLayer>
#> Name: Skilled Nursing Facilities
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $layers$`8`
#> <FeatureLayer>
#> Name: Skilled Nursing Facility_Dually
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $layers$`9`
#> <FeatureLayer>
#> Name: Skilled Nursing Facility_Distinct
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> $layers$`10`
#> <FeatureLayer>
#> Name: Nursing Facilities
#> Geometry Type: esriGeometryPoint
#> CRS: 3857
#> Capabilities: Map,Query,Data
#> 
#> 
hrsa_fields("asc", FL)
#> # A data frame: 17 × 5
#>    name                          type                  alias       length domain
#>  * <chr>                         <chr>                 <chr>        <int> <lgl> 
#>  1 CMS_PROVIDER_ADDRESS          esriFieldTypeString   CMS_PROVID…    150 NA    
#>  2 CMS_PROVIDER_CAT_CD           esriFieldTypeString   CMS_PROVID…      2 NA    
#>  3 CMS_PROVIDER_CAT_SUB_TYP_CD   esriFieldTypeString   CMS_PROVID…      2 NA    
#>  4 CMS_PROVIDER_CITY             esriFieldTypeString   CMS_PROVID…     50 NA    
#>  5 CMS_PROVIDER_NUM              esriFieldTypeString   CMS_PROVID…     10 NA    
#>  6 CMS_PROVIDER_ZIP_CD           esriFieldTypeString   CMS_PROVID…     15 NA    
#>  7 CMS_PROVIDER_CAT_DESC         esriFieldTypeString   Facility C…    100 NA    
#>  8 FACILITY_NM                   esriFieldTypeString   Facility N…    100 NA    
#>  9 CMS_PROVIDER_CAT_SUB_TYP_DESC esriFieldTypeString   Facility S…    100 NA    
#> 10 FAX_NUM                       esriFieldTypeString   FAX_NUM         25 NA    
#> 11 FREE_STANDING_IND             esriFieldTypeString   FREE_STAND…      1 NA    
#> 12 HOSPITAL_BASED_IND            esriFieldTypeString   HOSPITAL_B…      1 NA    
#> 13 OBJECTID                      esriFieldTypeOID      OBJECTID        NA NA    
#> 14 OPERATING_ROOM_CT             esriFieldTypeInteger  OPERATING_…     NA NA    
#> 15 PHONE_NUM                     esriFieldTypeString   PHONE_NUM       25 NA    
#> 16 Shape                         esriFieldTypeGeometry Shape           NA NA    
#> 17 CMS_PROVIDER_STATE_ABBR       esriFieldTypeString   State Abbr…      2 NA    
# hrsa_select("asc", FL)
```
