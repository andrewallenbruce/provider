# Linking Providers

## NPIs, PACs, ENIDs, CCNs, CLIAs and Many More

``` r
pac <- affiliations(pac = 7810891009)
gt(pac, rownames_to_stub = TRUE) |> 
  opt_table_font(font = google_font(name = "JetBrains Mono"), size = gt::px(12))
```

|     | npi        | pac        | last | first | middle | suffix | facility_type | facility_ccn | parent_ccn |
|-----|------------|------------|------|-------|--------|--------|---------------|--------------|------------|
| 1   | 1043245657 | 7810891009 | FUNG | MARK  | K      | NA     | Hospital      | 470003       | NA         |
| 2   | 1043245657 | 7810891009 | FUNG | MARK  | K      | NA     | Hospital      | 330250       | NA         |
| 3   | 1043245657 | 7810891009 | FUNG | MARK  | K      | NA     | Hospital      | 331321       | NA         |
| 4   | 1043245657 | 7810891009 | FUNG | MARK  | K      | NA     | Hospital      | 470001       | NA         |
| 5   | 1043245657 | 7810891009 | FUNG | MARK  | K      | NA     | Hospital      | 471307       | NA         |

``` r
ccn <- hospitals(ccn = unique(pac$facility_ccn))
gt(ccn, 
   groupname_col = "org_name", 
   rowname_col = "dba_name", 
   row_group_as_column = TRUE, 
   rownames_to_stub = TRUE) |> 
  opt_table_font(
    font = google_font(name = "JetBrains Mono"), 
    size = px(12))
```

|                                                     |     | enid            | enid_state | spec_cd | specialty                                  | npi        | multi | ccn    | pac        | dba_name                                                               | inc_date   | inc_state | org_type    | org_text | designation | add_1              | add_2 | city        | state | zip       | location_type                    | location_text                           | sub_general | sub_acute | sub_drug | sub_child | sub_long | sub_psych | sub_rehab | sub_short | sub_swing | sub_psych_unit | sub_rehab_unit | sub_specialty | sub_other | sub_otext                | reh_ind | reh_date | old_ccn |
|-----------------------------------------------------|-----|-----------------|------------|---------|--------------------------------------------|------------|-------|--------|------------|------------------------------------------------------------------------|------------|-----------|-------------|----------|-------------|--------------------|-------|-------------|-------|-----------|----------------------------------|-----------------------------------------|-------------|-----------|----------|-----------|----------|-----------|-----------|-----------|-----------|----------------|----------------|---------------|-----------|--------------------------|---------|----------|---------|
| CHAMPLAIN VALLEY PHYSICIANS HOSPITAL MEDICAL CENTER | 1   | O20120110000201 | NY         | 00-09   | PART A PROVIDER - HOSPITAL                 | 1033270699 | N     | 330250 | 2769396878 | THE UNIVERSITY OF VT HEALTH NETWORK - CHAMPLAIN VALLEY PHYSICIANS HOSP | 1926-01-01 | NY        | CORPORATION | NA       | N           | 75 BEEKMAN ST      | NA    | PLATTSBURGH | NY    | 129011438 | MAIN/PRIMARY HOSPITAL LOCATION   | NA                                      | N           | Y         | N        | N         | N        | N         | N         | N         | N         | N              | N              | N             | N         | NA                       | N       | NA       | NA      |
| ALICE HYDE MEDICAL CENTER                           | 2   | O20230512000344 | NY         | 00-85   | PART A PROVIDER - CRITICAL ACCESS HOSPITAL | 1114954682 | N     | 331321 | 4082525837 | THE UNIVERSITY OF VERMONT HEALTH NETWORK-ALICE HYDE MEDICAL CENTER     | 1905-04-13 | NY        | CORPORATION | NA       | N           | 133 PARK ST        | NA    | MALONE      | NY    | 129531244 | MAIN/PRIMARY HOSPITAL LOCATION   | NA                                      | N           | N         | N        | N         | N        | N         | N         | N         | N         | N              | N              | N             | N         | NA                       | N       | NA       | NA      |
| CENTRAL VERMONT MEDICAL CENTER INC                  | 3   | O20050809000650 | VT         | 00-09   | PART A PROVIDER - HOSPITAL                 | 1508845637 | N     | 470001 | 9335138817 | NA                                                                     | 1984-03-01 | VT        | CORPORATION | NA       | N           | 130 FISHER RD      | NA    | BERLIN      | VT    | 56029516  | MAIN/PRIMARY HOSPITAL LOCATION   | NA                                      | N           | Y         | N        | N         | N        | N         | N         | N         | N         | N              | N              | N             | N         | NA                       | N       | NA       | NA      |
| UNIVERSITY OF VERMONT MEDICAL CENTER INC            | 4   | O20021111000009 | VT         | 00-09   | PART A PROVIDER - HOSPITAL                 | 1568419976 | N     | 470003 | 3779491071 | UNIVERSITY OF VERMONT MEDICAL CENTER                                   | 1995-01-01 | VT        | CORPORATION | NA       | N           | 111 COLCHESTER AVE | NA    | BURLINGTON  | VT    | 54011473  | OTHER HOSPITAL PRACTICE LOCATION | HOSPITAL - GENERAL PRACTICE AND CLINICS | N           | Y         | N        | N         | N        | N         | N         | N         | N         | N              | N              | N             | Y         | ORGAN TRANSPLANT PROGRAM | N       | NA       | NA      |
| PORTER HOSPITAL INC                                 | 5   | O20061104000607 | VT         | 00-85   | PART A PROVIDER - CRITICAL ACCESS HOSPITAL | 1740291400 | Y     | 471307 | 1850365180 | NA                                                                     | 1986-11-14 | VT        | CORPORATION | NA       | N           | 115 PORTER DR      | NA    | MIDDLEBURY  | VT    | 57538423  | MAIN/PRIMARY HOSPITAL LOCATION   | NA                                      | N           | N         | N        | N         | N        | N         | N         | N         | N         | N              | N              | N             | N         | NA                       | N       | NA       | NA      |

  

Exploring links between providers can lead to many interesting insights.
For example, there is a hospital in New York named **Elizabethtown
Community Hospital**.

``` r
providers(org_name = "Elizabethtown Community Hospital") |> 
  gt(rownames_to_stub = TRUE) |> 
  opt_table_font(
    font = google_font(name = "JetBrains Mono"), 
    size = px(12))
```

|     | npi        | multi | pac        | enid            | spec  | specialty                                    | state | last | first | middle | org_name                         |
|-----|------------|-------|------------|-----------------|-------|----------------------------------------------|-------|------|-------|--------|----------------------------------|
| 1   | 1053656744 | Y     | 3577554138 | O20040521000534 | 12-70 | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | NY    | NA   | NA    | NA     | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 2   | 1891785184 | Y     | 3577554138 | O20101110000259 | 00-85 | PART A PROVIDER - CRITICAL ACCESS HOSPITAL   | NY    | NA   | NA    | NA     | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 3   | 1487923637 | N     | 3577554138 | O20190719002511 | 12-59 | PART B SUPPLIER - AMBULANCE SERVICE SUPPLIER | NY    | NA   | NA    | NA     | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 4   | 1407061591 | N     | 3577554138 | O20220827000145 | 00-85 | PART A PROVIDER - CRITICAL ACCESS HOSPITAL   | NY    | NA   | NA    | NA     | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 5   | 1053656744 | N     | 3577554138 | O20240508002551 | 12-70 | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | CT    | NA   | NA    | NA     | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 6   | 1053656744 | N     | 3577554138 | O20240509001572 | 12-70 | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | FL    | NA   | NA    | NA     | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 7   | 1053656744 | N     | 3577554138 | O20240515002137 | 12-70 | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | VT    | NA   | NA    | NA     | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 8   | 1053656744 | N     | 3577554138 | O20250909000919 | 12-70 | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | NH    | NA   | NA    | NA     | ELIZABETHTOWN COMMUNITY HOSPITAL |
| 9   | 1053656744 | N     | 3577554138 | O20250912004448 | 12-70 | PART B SUPPLIER - CLINIC/GROUP PRACTICE      | CO    | NA   | NA    | NA     | ELIZABETHTOWN COMMUNITY HOSPITAL |

``` r
hospitals(org_name = "Elizabethtown Community Hospital") |> 
  gt(rownames_to_stub = TRUE) |> 
  opt_table_font(
    font = google_font(name = "JetBrains Mono"), 
    size = px(12))
```

|     | enid            | enid_state | spec_cd | specialty                                  | npi        | multi | ccn    | pac        | org_name                         | dba_name | inc_date   | inc_state | org_type    | org_text | designation | add_1      | add_2 | city          | state | zip       | location_type                    | location_text | sub_general | sub_acute | sub_drug | sub_child | sub_long | sub_psych | sub_rehab | sub_short | sub_swing | sub_psych_unit | sub_rehab_unit | sub_specialty | sub_other | sub_otext | reh_ind | reh_date | old_ccn |
|-----|-----------------|------------|---------|--------------------------------------------|------------|-------|--------|------------|----------------------------------|----------|------------|-----------|-------------|----------|-------------|------------|-------|---------------|-------|-----------|----------------------------------|---------------|-------------|-----------|----------|-----------|----------|-----------|-----------|-----------|-----------|----------------|----------------|---------------|-----------|-----------|---------|----------|---------|
| 1   | O20101110000259 | NY         | 00-85   | PART A PROVIDER - CRITICAL ACCESS HOSPITAL | 1891785184 | Y     | 331302 | 3577554138 | ELIZABETHTOWN COMMUNITY HOSPITAL | NA       | 1926-05-08 | NY        | CORPORATION | NA       | N           | 75 PARK ST | NA    | ELIZABETHTOWN | NY    | 129322300 | OTHER HOSPITAL PRACTICE LOCATION | NA            | N           | N         | N        | N         | N        | N         | N         | N         | N         | N              | N              | N             | N         | NA        | N       | NA       | NA      |
| 2   | O20220827000145 | NY         | 00-85   | PART A PROVIDER - CRITICAL ACCESS HOSPITAL | 1407061591 | N     | 33Z302 | 3577554138 | ELIZABETHTOWN COMMUNITY HOSPITAL | NA       | 1926-05-08 | NY        | CORPORATION | NA       | N           | 75 PARK ST | NA    | ELIZABETHTOWN | NY    | 129322300 | OTHER HOSPITAL PRACTICE LOCATION | NA            | N           | N         | N        | N         | N        | N         | N         | N         | N         | N              | N              | N             | N         | NA        | N       | NA       | NA      |

  

The **Hospital Enrollment** API includes only Medicare Part A (hospital)
providers, so we only get two rows back, but those include a new data
point: two facility CCNs. Plugging those into the **Facility
Affiliations** API, we can retrieve information on the individual
providers practicing at this hospital. First, the all-numeric CCN
(`331302`):

  

``` r
affiliations(facility_ccn = 331302) |> 
  gt(rownames_to_stub = TRUE) |> 
  opt_table_font(
    font = google_font(name = "JetBrains Mono"), 
    size = px(12))
```

|     | npi        | pac        | last                | first          | middle   | suffix | facility_type | facility_ccn | parent_ccn |
|-----|------------|------------|---------------------|----------------|----------|--------|---------------|--------------|------------|
| 1   | 1003845272 | 1759384035 | GREENE              | LAURA          | A        | NA     | Hospital      | 331302       | NA         |
| 2   | 1013141860 | 8022069558 | KAMPSCHROR          | DEBORAH        | M        | NA     | Hospital      | 331302       | NA         |
| 3   | 1013539584 | 9133544109 | VASSILIAN           | NAROD          | NA       | NA     | Hospital      | 331302       | NA         |
| 4   | 1013595560 | 3375947401 | TRIPLETT            | EMILY          | NA       | NA     | Hospital      | 331302       | NA         |
| 5   | 1013910256 | 5890719371 | ACOSTAMADIEDO       | JOSE           | M        | NA     | Hospital      | 331302       | NA         |
| 6   | 1023377843 | 6901115278 | WILHELM             | LINDSEY        | B        | NA     | Hospital      | 331302       | NA         |
| 7   | 1043672140 | 7214229350 | FIORINI FURTADO     | VANESSA        | NA       | NA     | Hospital      | 331302       | NA         |
| 8   | 1063420891 | 9436051687 | YOUNG               | JOHN           | NA       | NA     | Hospital      | 331302       | NA         |
| 9   | 1073073177 | 0547593097 | OSBORN              | DELANEY        | NA       | NA     | Hospital      | 331302       | NA         |
| 10  | 1073133435 | 6800318452 | GILL                | ANGAD          | NA       | NA     | Hospital      | 331302       | NA         |
| 11  | 1073258398 | 3870095805 | KLOTZ               | JEFFREY        | NA       | NA     | Hospital      | 331302       | NA         |
| 12  | 1073572236 | 7012816168 | RHEEMAN             | CHARLES        | H        | NA     | Hospital      | 331302       | NA         |
| 13  | 1073634531 | 9234285487 | GILBERT             | MATTHEW        | P        | NA     | Hospital      | 331302       | NA         |
| 14  | 1073660684 | 1759418007 | BIGELOW             | GAYLEN         | M        | NA     | Hospital      | 331302       | NA         |
| 15  | 1083148837 | 0042564882 | KRULEWITZ           | NEIL           | A        | NA     | Hospital      | 331302       | NA         |
| 16  | 1083861934 | 2860555141 | ELLIOTT             | STEVEN         | J        | NA     | Hospital      | 331302       | NA         |
| 17  | 1083887137 | 8921256520 | WALSH               | RYAN           | NA       | NA     | Hospital      | 331302       | NA         |
| 18  | 1093386070 | 3476085051 | GADELHA PIEROTTI    | ELISSA         | JENSEN   | NA     | Hospital      | 331302       | NA         |
| 19  | 1093796898 | 5597848077 | MAHONEY             | ANDREW         | C        | NA     | Hospital      | 331302       | NA         |
| 20  | 1104118330 | 0547408825 | BROWN               | JODI           | AU       | NA     | Hospital      | 331302       | NA         |
| 21  | 1114269503 | 6204138928 | AYERS               | CATHERINE      | A        | NA     | Hospital      | 331302       | NA         |
| 22  | 1114345873 | 7810114279 | LIU                 | JANE           | Z        | NA     | Hospital      | 331302       | NA         |
| 23  | 1124857743 | 7517493471 | ASHLINE             | EMILY          | A        | NA     | Hospital      | 331302       | NA         |
| 24  | 1134186703 | 2567476948 | KENNEY              | JAMES          | NA       | NA     | Hospital      | 331302       | NA         |
| 25  | 1154379063 | 1759394851 | LOBEL               | ROBERT         | MICHAEL  | NA     | Hospital      | 331302       | NA         |
| 26  | 1154411882 | 9638156946 | BAMFORD             | BENJAMIN       | NA       | NA     | Hospital      | 331302       | NA         |
| 27  | 1164491221 | 1759412109 | HUBER               | DANIEL         | NA       | NA     | Hospital      | 331302       | NA         |
| 28  | 1164787610 | 3476705013 | MAHONEY             | MARGARET       | A        | NA     | Hospital      | 331302       | NA         |
| 29  | 1174057699 | 3678805512 | ESSA                | AMR            | NA       | NA     | Hospital      | 331302       | NA         |
| 30  | 1184179103 | 4789962846 | KADER               | TINA           | NA       | NA     | Hospital      | 331302       | NA         |
| 31  | 1184285751 | 0941632020 | MONTELLO            | NICHOLAS       | J        | NA     | Hospital      | 331302       | NA         |
| 32  | 1184637233 | 3173599834 | PALMA               | CHRISTOPHER    | S        | NA     | Hospital      | 331302       | NA         |
| 33  | 1194033464 | 0042502544 | DESO                | STEVEN         | E        | NA     | Hospital      | 331302       | NA         |
| 34  | 1194875310 | 5991734212 | SLATCH              | HARRY          | H        | NA     | Hospital      | 331302       | NA         |
| 35  | 1205831658 | 1355353202 | CHASE               | MICHAEL        | P        | NA     | Hospital      | 331302       | NA         |
| 36  | 1205960812 | 3173647716 | HOWARD              | KATHERINE      | J        | NA     | Hospital      | 331302       | NA         |
| 37  | 1215634175 | 2567992514 | SATTER              | RACHEL         | L        | NA     | Hospital      | 331302       | NA         |
| 38  | 1215905435 | 7517091168 | HUBER               | DEBORAH        | A        | NA     | Hospital      | 331302       | NA         |
| 39  | 1215918313 | 0042202855 | BYRNE               | WILLIAM        | J        | NA     | Hospital      | 331302       | NA         |
| 40  | 1225219884 | 2163615626 | EL AZOURY           | PAUL           | G        | NA     | Hospital      | 331302       | NA         |
| 41  | 1235283482 | 0143307462 | GAUTHIER            | ERIC           | A        | NA     | Hospital      | 331302       | NA         |
| 42  | 1235699828 | 8628301264 | ALSOFROM            | NICHOLAS       | G        | NA     | Hospital      | 331302       | NA         |
| 43  | 1245492842 | 0042451403 | HENRY               | BRIAN          | D        | NA     | Hospital      | 331302       | NA         |
| 44  | 1255305553 | 6103838842 | COOMBES             | JOHN           | M        | NA     | Hospital      | 331302       | NA         |
| 45  | 1255350609 | 7911951983 | SHEESER             | JON            | MICHAEL  | NA     | Hospital      | 331302       | NA         |
| 46  | 1265443600 | 3971643016 | GABLER              | JAMES          | O        | NA     | Hospital      | 331302       | NA         |
| 47  | 1265925630 | 9830440759 | GILLOTEAUX          | LAURENT        | NA       | NA     | Hospital      | 331302       | NA         |
| 48  | 1275527004 | 3971785767 | ROMANOWSKI          | ROSLYN         | R        | NA     | Hospital      | 331302       | NA         |
| 49  | 1285697128 | 7719941152 | DORSEY              | DANIEL         | COLLIN   | NA     | Hospital      | 331302       | NA         |
| 50  | 1285727792 | 9133244213 | LENIHAN             | MICHAEL        | W        | NA     | Hospital      | 331302       | NA         |
| 51  | 1285738278 | 4981633963 | DESMANGLES          | GILBERT        | NA       | NA     | Hospital      | 331302       | NA         |
| 52  | 1316444326 | 4486058971 | INGLIS              | ROBERT         | D        | NA     | Hospital      | 331302       | NA         |
| 53  | 1326034992 | 8224071410 | PERRAPATO           | SCOTT          | D        | NA     | Hospital      | 331302       | NA         |
| 54  | 1326508417 | 4688909666 | WARNER              | JACOB          | NA       | NA     | Hospital      | 331302       | NA         |
| 55  | 1336129964 | 3971581497 | MARTIN              | LINDA          | ANN      | NA     | Hospital      | 331302       | NA         |
| 56  | 1346505732 | 0244482313 | LOVING              | JEREMY         | J        | NA     | Hospital      | 331302       | NA         |
| 57  | 1346602257 | 1759612914 | MARLOW              | JOSHUA         | NA       | NA     | Hospital      | 331302       | NA         |
| 58  | 1346730736 | 3678826591 | BARBOUR             | KYLE           | NA       | NA     | Hospital      | 331302       | NA         |
| 59  | 1356579171 | 5991948382 | PERCARPIO           | ROBERT         | NA       | NA     | Hospital      | 331302       | NA         |
| 60  | 1356848857 | 4688095920 | BLISS               | WENDELL        | A        | NA     | Hospital      | 331302       | NA         |
| 61  | 1366544017 | 6002966249 | BULLOCK             | DANIEL         | P        | NA     | Hospital      | 331302       | NA         |
| 62  | 1366934432 | 0345659066 | WHITLEDGE           | JAMES          | D        | NA     | Hospital      | 331302       | NA         |
| 63  | 1376811976 | 6901063049 | CRYSTAL             | SARA           | M        | NA     | Hospital      | 331302       | NA         |
| 64  | 1376938837 | 7618215161 | MIRBAGHERI          | SAEEDEH        | NA       | NA     | Hospital      | 331302       | NA         |
| 65  | 1386136851 | 1153676846 | MICHAELI            | NICHOLE        | NA       | NA     | Hospital      | 331302       | NA         |
| 66  | 1386999597 | 3678821451 | NEVARES             | ALANA          | M        | NA     | Hospital      | 331302       | NA         |
| 67  | 1396758520 | 8729261144 | HURWITZ             | CRAIG          | G        | NA     | Hospital      | 331302       | NA         |
| 68  | 1396818100 | 0941259220 | ZUBARIK             | RICHARD        | NA       | NA     | Hospital      | 331302       | NA         |
| 69  | 1396989059 | 8921259557 | HALLORAN            | MARY           | K        | NA     | Hospital      | 331302       | NA         |
| 70  | 1407068141 | 7416040043 | SAKAL               | CHRISTOPHER    | D.       | NA     | Hospital      | 331302       | NA         |
| 71  | 1417130410 | 0749332229 | SLIM                | HANNA          | B        | NA     | Hospital      | 331302       | NA         |
| 72  | 1417242348 | 3476825829 | SZCZECH             | BARTLOMIEJ     | WOJCIECH | NA     | Hospital      | 331302       | NA         |
| 73  | 1417376013 | 8426343252 | BOURLA              | MICHAEL        | NA       | NA     | Hospital      | 331302       | NA         |
| 74  | 1417937780 | 5597722421 | OUYANG              | DAVID          | T        | NA     | Hospital      | 331302       | NA         |
| 75  | 1427175330 | 1153518063 | GARRISON            | GARTH          | W        | NA     | Hospital      | 331302       | NA         |
| 76  | 1427258615 | 7911078134 | ZIGMUND             | BETH           | NA       | NA     | Hospital      | 331302       | NA         |
| 77  | 1427552058 | 3274889514 | ELDER               | NATALIE        | M        | NA     | Hospital      | 331302       | NA         |
| 78  | 1427602218 | 0446683510 | SETHI               | SAMEER         | NA       | NA     | Hospital      | 331302       | NA         |
| 79  | 1437183183 | 6406907435 | GAIOTTI-GRUBBS      | DARCI          | A        | NA     | Hospital      | 331302       | NA         |
| 80  | 1437505088 | 5890087886 | ELLSWORTH           | DAVID          | F        | NA     | Hospital      | 331302       | NA         |
| 81  | 1437714037 | 2668808924 | NAUGHTER            | MARGARET       | LEE      | NA     | Hospital      | 331302       | NA         |
| 82  | 1447415971 | 3678880614 | MIR                 | SADAF          | N        | NA     | Hospital      | 331302       | NA         |
| 83  | 1447539507 | 4789802299 | MACK                | KRISTIN        | L        | NA     | Hospital      | 331302       | NA         |
| 84  | 1457745903 | 5193028496 | CLEVELAND           | CURTIS         | H        | NA     | Hospital      | 331302       | NA         |
| 85  | 1457757221 | 3375856784 | ALIX                | KRISTINE       | BLAIS    | NA     | Hospital      | 331302       | NA         |
| 86  | 1467171124 | 9335524305 | NASRI               | AMINE          | NA       | NA     | Hospital      | 331302       | NA         |
| 87  | 1477125490 | 5092243360 | LUBIN               | JADY           | KESLERE  | NA     | Hospital      | 331302       | NA         |
| 88  | 1477556181 | 4789682253 | ROWLEY              | PATRICK        | NA       | NA     | Hospital      | 331302       | NA         |
| 89  | 1477567121 | 3577690254 | CULLITON            | TIMOTHY        | A        | NA     | Hospital      | 331302       | NA         |
| 90  | 1477788099 | 1759420920 | MARTELL             | ROBERT         | E        | NA     | Hospital      | 331302       | NA         |
| 91  | 1477873776 | 6901093269 | FORBES              | LORNA          | C        | NA     | Hospital      | 331302       | NA         |
| 92  | 1487231031 | 5496158644 | MCCORMICK           | ASHLEY         | NA       | NA     | Hospital      | 331302       | NA         |
| 93  | 1497712541 | 8921012303 | BULA                | WOLODYMYR      | I        | NA     | Hospital      | 331302       | NA         |
| 94  | 1497945596 | 4789760976 | LODHA               | SEEMA          | A        | NA     | Hospital      | 331302       | NA         |
| 95  | 1508095399 | 5698816759 | HAUSRATH            | CARLA          | K        | NA     | Hospital      | 331302       | NA         |
| 96  | 1508336868 | 7113264557 | ARGUELLES           | TRACY          | A        | NA     | Hospital      | 331302       | NA         |
| 97  | 1508949009 | 8527200872 | ANDERSON            | JULIE          | A.       | NA     | Hospital      | 331302       | NA         |
| 98  | 1518161496 | 1759477144 | IMOBERSTEG          | ALBERT         | M        | NA     | Hospital      | 331302       | NA         |
| 99  | 1518359116 | 8729376470 | CADET               | NIKITA         | NA       | NA     | Hospital      | 331302       | NA         |
| 100 | 1528499910 | 9032349105 | KENNEDY             | ELAN           | B        | NA     | Hospital      | 331302       | NA         |
| 101 | 1528661675 | 2264846021 | VORSTEVELD          | LYDIA          | NA       | NA     | Hospital      | 331302       | NA         |
| 102 | 1538173869 | 0547299091 | CHON                | IL             | JUN      | NA     | Hospital      | 331302       | NA         |
| 103 | 1538502901 | 6800181504 | MULVEY              | LAURA          | A        | NA     | Hospital      | 331302       | NA         |
| 104 | 1538553656 | 0941501134 | GILLETT             | SARAH          | RUTH     | NA     | Hospital      | 331302       | NA         |
| 105 | 1548223001 | 9739093352 | BLIVEN              | CHRISTINE      | MORRISON | NA     | Hospital      | 331302       | NA         |
| 106 | 1548374382 | 9537283122 | DIER                | DOUGLAS        | NA       | NA     | Hospital      | 331302       | NA         |
| 107 | 1548847155 | 1355745175 | COLLIER             | KATHRYN        | C        | NA     | Hospital      | 331302       | NA         |
| 108 | 1548895428 | 5193121531 | DROLLETTE           | KELLY          | L        | NA     | Hospital      | 331302       | NA         |
| 109 | 1558659367 | 6709004682 | BANU                | DRAGOS         | NA       | NA     | Hospital      | 331302       | NA         |
| 110 | 1558857763 | 7719239888 | MCCABE              | DEVON          | NA       | NA     | Hospital      | 331302       | NA         |
| 111 | 1568467918 | 0446262398 | BAUER               | WILLIAM        | M        | NA     | Hospital      | 331302       | NA         |
| 112 | 1578981098 | 9537461116 | BARRETT             | KAITLYN        | NA       | NA     | Hospital      | 331302       | NA         |
| 113 | 1588635999 | 3476508680 | GARRISON            | DAVID          | M        | NA     | Hospital      | 331302       | NA         |
| 114 | 1619174612 | 2961574488 | IRWIN               | BRIAN          | H        | NA     | Hospital      | 331302       | NA         |
| 115 | 1619243110 | 8921378688 | VASILIOU            | ELYA           | NA       | NA     | Hospital      | 331302       | NA         |
| 116 | 1629203559 | 6204091465 | VIETH               | JULIE          | T        | NA     | Hospital      | 331302       | NA         |
| 117 | 1629241336 | 4385805696 | AKSELROD            | DMITRIY        | G        | NA     | Hospital      | 331302       | NA         |
| 118 | 1629280896 | 3173770591 | BELLER              | JENNIFER       | P        | NA     | Hospital      | 331302       | NA         |
| 119 | 1629401864 | 7618102294 | BLANKSTEIN          | MICHAEL        | NA       | NA     | Hospital      | 331302       | NA         |
| 120 | 1629606363 | 0547673287 | SLEEPER             | JON            | NA       | NA     | Hospital      | 331302       | NA         |
| 121 | 1639121858 | 1951316116 | NICHITA             | ELENA          | C        | NA     | Hospital      | 331302       | NA         |
| 122 | 1639167737 | 9830161686 | GILLANI             | AQEEL          | A        | NA     | Hospital      | 331302       | NA         |
| 123 | 1649272402 | 4082602636 | DEBOER              | KEVIN          | NA       | NA     | Hospital      | 331302       | NA         |
| 124 | 1649664913 | 6002144482 | KENNEDY             | JOSEPH         | M        | NA     | Hospital      | 331302       | NA         |
| 125 | 1649699125 | 3678876323 | MASON               | RYAN           | NA       | NA     | Hospital      | 331302       | NA         |
| 126 | 1649859703 | 0042614265 | ROSENBERG           | MICHAEL        | A        | NA     | Hospital      | 331302       | NA         |
| 127 | 1659534212 | 5890963920 | LAHOUD              | RONY           | N        | NA     | Hospital      | 331302       | NA         |
| 128 | 1659635944 | 8921235227 | SLEEPER             | CARLY          | J        | NA     | Hospital      | 331302       | NA         |
| 129 | 1659734861 | 1456646918 | HAIMES              | MARK           | A        | NA     | Hospital      | 331302       | NA         |
| 130 | 1669032470 | 5496083545 | ANDERSON            | ELIZABETH      | NA       | NA     | Hospital      | 331302       | NA         |
| 131 | 1669793121 | 4082987896 | HAINES              | JOHN           | NA       | NA     | Hospital      | 331302       | NA         |
| 132 | 1679034847 | 5799018248 | PLOCHOCKI           | ALEXANDER      | NA       | NA     | Hospital      | 331302       | NA         |
| 133 | 1679681399 | 6406899715 | LEE                 | YOUNG-MEE      | NA       | NA     | Hospital      | 331302       | NA         |
| 134 | 1679732473 | 4385890656 | VIOLA               | TRACEY         | A        | NA     | Hospital      | 331302       | NA         |
| 135 | 1689085748 | 3375844525 | KANNER              | CHRISTOPHER    | NA       | NA     | Hospital      | 331302       | NA         |
| 136 | 1689736720 | 1254525835 | LEMOS               | JULIO          | A        | NA     | Hospital      | 331302       | NA         |
| 137 | 1689835589 | 6901964253 | KIM                 | DOUGLAS        | J        | NA     | Hospital      | 331302       | NA         |
| 138 | 1700204922 | 5991006751 | CHRISTENSEN         | DAVID          | D        | NA     | Hospital      | 331302       | NA         |
| 139 | 1710203765 | 4486887007 | RATTNER             | PETER          | NA       | NA     | Hospital      | 331302       | NA         |
| 140 | 1710204573 | 4981896362 | AGHELI              | AREF           | NA       | NA     | Hospital      | 331302       | NA         |
| 141 | 1710920186 | 1254341555 | MCMEEKIN-HAGADORN   | SHANNON        | A        | NA     | Hospital      | 331302       | NA         |
| 142 | 1720091861 | 6002882768 | WOLKOWICZ           | JOEL           | M        | NA     | Hospital      | 331302       | NA         |
| 143 | 1720187537 | 2264336411 | VOLK                | CHARLES        | P        | NA     | Hospital      | 331302       | NA         |
| 144 | 1720475924 | 3678869328 | ALEXIS              | ANEL           | NA       | NA     | Hospital      | 331302       | NA         |
| 145 | 1730177825 | 3072543610 | HOGAN MOULTON       | AMY            | E        | NA     | Hospital      | 331302       | NA         |
| 146 | 1740297548 | 0648249979 | DEMING              | KARIE          | NA       | NA     | Hospital      | 331302       | NA         |
| 147 | 1740862499 | 2769918614 | GOODMAN-O'LEARY     | WESLEY         | L        | NA     | Hospital      | 331302       | NA         |
| 148 | 1750006227 | 5193196764 | LAWLISS             | ELIZABETH      | M        | NA     | Hospital      | 331302       | NA         |
| 149 | 1750315628 | 9133126485 | IONESCU             | GABRIEL        | NA       | NA     | Hospital      | 331302       | NA         |
| 150 | 1750335014 | 6002861804 | NOBLE               | GAVIN          | L        | NA     | Hospital      | 331302       | NA         |
| 151 | 1750605259 | 8325343700 | BORDEAU             | CHRISTINA      | M        | NA     | Hospital      | 331302       | NA         |
| 152 | 1750940151 | 9638404296 | BACHILAS            | HOLLY          | E        | NA     | Hospital      | 331302       | NA         |
| 153 | 1760167712 | 8123473469 | WARNER              | JOSHUA         | NA       | NA     | Hospital      | 331302       | NA         |
| 154 | 1760527113 | 4789784992 | KARAM               | NICOLAS        | M        | NA     | Hospital      | 331302       | NA         |
| 155 | 1760922454 | 4183900152 | CRAVEN              | KYLE           | C        | NA     | Hospital      | 331302       | NA         |
| 156 | 1770068371 | 1658615281 | ALLEN               | LOREN          | M        | NA     | Hospital      | 331302       | NA         |
| 157 | 1770652323 | 3870776032 | PHILLIPS            | VICTORIA       | J        | NA     | Hospital      | 331302       | NA         |
| 158 | 1770689986 | 7214905645 | PIZARRO             | GLENN          | NA       | NA     | Hospital      | 331302       | NA         |
| 159 | 1790786051 | 2062542475 | VACCARO             | ANTHONY        | NA       | NA     | Hospital      | 331302       | NA         |
| 160 | 1801346796 | 5193095248 | MERCHAND            | MORGAN         | NA       | NA     | Hospital      | 331302       | NA         |
| 161 | 1801800529 | 7517092125 | BOLLINGER           | FRANCES        | C        | NA     | Hospital      | 331302       | NA         |
| 162 | 1801893318 | 3577568724 | DEMURO              | ROB            | L        | NA     | Hospital      | 331302       | NA         |
| 163 | 1811952583 | 9931092434 | CAPUTO              | PASQUALINO     | NA       | NA     | Hospital      | 331302       | NA         |
| 164 | 1821265174 | 0840343380 | JACQUET             | GABRIELLE      | A        | NA     | Hospital      | 331302       | NA         |
| 165 | 1831751726 | 1759756380 | SILOTCH             | ANATOL         | NA       | NA     | Hospital      | 331302       | NA         |
| 166 | 1831862663 | 8325436058 | RUSHBY              | MICHELLE       | MARIE    | NA     | Hospital      | 331302       | NA         |
| 167 | 1851620124 | 4183765258 | FRIEBEL             | ANDREW         | M        | NA     | Hospital      | 331302       | NA         |
| 168 | 1851886451 | 4486057981 | HAWA                | SALAM          | NA       | NA     | Hospital      | 331302       | NA         |
| 169 | 1861057010 | 5799118121 | FORTIN              | MELANIE        | P        | NA     | Hospital      | 331302       | NA         |
| 170 | 1861470247 | 0143386862 | SHIP                | JORDAN         | R        | NA     | Hospital      | 331302       | NA         |
| 171 | 1861757064 | 6800129123 | PERSAUD             | VINCENT        | NA       | NA     | Hospital      | 331302       | NA         |
| 172 | 1861843963 | 4385922863 | GERGI               | MANSOUR        | NA       | NA     | Hospital      | 331302       | NA         |
| 173 | 1861869950 | 9133437122 | WILLIAMS            | ASHLEY         | N        | NA     | Hospital      | 331302       | NA         |
| 174 | 1871085134 | 3173927183 | WARK                | TYLER          | NA       | NA     | Hospital      | 331302       | NA         |
| 175 | 1871781716 | 2466505102 | KHORASHADI          | LEILA          | NA       | NA     | Hospital      | 331302       | NA         |
| 176 | 1881057149 | 0244526770 | CASSONE             | MARC           | A        | NA     | Hospital      | 331302       | NA         |
| 177 | 1881128528 | 0244501682 | KHOSHNOODI          | POORIA         | NA       | NA     | Hospital      | 331302       | NA         |
| 178 | 1881139863 | 4486930641 | SHANNON             | GRANT          | NA       | NA     | Hospital      | 331302       | NA         |
| 179 | 1881274322 | 1557764685 | GERSHTEYN           | VALERIYA       | NA       | NA     | Hospital      | 331302       | NA         |
| 180 | 1881823649 | 5496997595 | JACQUES             | YAMILEE        | A        | NA     | Hospital      | 331302       | NA         |
| 181 | 1891816740 | 9133362262 | MATARRESE           | MARISSA        | R        | NA     | Hospital      | 331302       | NA         |
| 182 | 1891908026 | 3274625280 | JEWELL              | RYAN PHILLIP   | P        | NA     | Hospital      | 331302       | NA         |
| 183 | 1902155880 | 9032363999 | GARRISON            | AMY            | S        | NA     | Hospital      | 331302       | NA         |
| 184 | 1902981871 | 6709886799 | ISHAC               | ROGER          | G        | NA     | Hospital      | 331302       | NA         |
| 185 | 1912358318 | 3577836410 | STAZIAKI            | PEDRO          | NA       | NA     | Hospital      | 331302       | NA         |
| 186 | 1912439399 | 4082033840 | PASKIN              | SAMUEL         | FLERLAGE | NA     | Hospital      | 331302       | NA         |
| 187 | 1912905068 | 2062482045 | BYRNE               | EUGENE         | NA       | NA     | Hospital      | 331302       | NA         |
| 188 | 1912995648 | 7911891924 | BENZ                | ERIC           | B        | NA     | Hospital      | 331302       | NA         |
| 189 | 1922014562 | 6103813993 | WOLFE               | CHRISTOPHER    | A        | NA     | Hospital      | 331302       | NA         |
| 190 | 1922348655 | 6103197454 | BLOOM               | ADAM           | S        | NA     | Hospital      | 331302       | NA         |
| 191 | 1922553361 | 9133408479 | CLINTON             | AIMEE          | B        | NA     | Hospital      | 331302       | NA         |
| 192 | 1932279049 | 2769430941 | WEBBER              | RICHARD        | A        | NA     | Hospital      | 331302       | NA         |
| 193 | 1932286523 | 8729002514 | PAPPAS              | CHARLES        | NA       | NA     | Hospital      | 331302       | NA         |
| 194 | 1942353255 | 5890810782 | BARTOS              | ELIZABETH      | A        | NA     | Hospital      | 331302       | NA         |
| 195 | 1942398755 | 8729085816 | PLANTE              | LAUREL         | B        | NA     | Hospital      | 331302       | NA         |
| 196 | 1952763575 | 2961797543 | EAST                | JAMES          | E        | NA     | Hospital      | 331302       | NA         |
| 197 | 1962433441 | 1456327659 | CORSE               | KENNETH        | J        | II     | Hospital      | 331302       | NA         |
| 198 | 1962473397 | 9931204500 | CLARK               | DEBRA          | J        | NA     | Hospital      | 331302       | NA         |
| 199 | 1962718551 | 6507083185 | AKSAMAWATI DIT ARJA | WAJIH          | NA       | NA     | Hospital      | 331302       | NA         |
| 200 | 1972063493 | 7315270790 | DALY                | MADISON        | L        | NA     | Hospital      | 331302       | NA         |
| 201 | 1972174381 | 0244638047 | NAPPER              | KAYLA          | MARIE    | NA     | Hospital      | 331302       | NA         |
| 202 | 1972525814 | 3274520358 | ROSSI               | MARIO          | NA       | NA     | Hospital      | 331302       | NA         |
| 203 | 1982606984 | 6901872548 | KELLY               | GREGORY        | A        | NA     | Hospital      | 331302       | NA         |
| 204 | 1992261887 | 4486981958 | APUZZO              | SERGIO         | NA       | NA     | Hospital      | 331302       | NA         |
| 205 | 1992459655 | 1759769557 | MOHAGHEGH POOR      | SEYED MOHAMMAD | NA       | NA     | Hospital      | 331302       | NA         |
| 206 | 1992993794 | 7113172685 | DAVIS               | ELLEN          | NA       | NA     | Hospital      | 331302       | NA         |

  

That returns individual providers affiliated with the hospital. Now to
search the alphanumeric CCN (`33Z302`):

``` r
affiliations(facility_ccn = "33Z302") |> 
  gt(rownames_to_stub = TRUE) |> 
  opt_table_font(
    font = google_font(name = "JetBrains Mono"), 
    size = px(12))
```

|     | npi        | pac        | last     | first   | middle | suffix | facility_type | facility_ccn | parent_ccn |
|-----|------------|------------|----------|---------|--------|--------|---------------|--------------|------------|
| 1   | 1073258398 | 3870095805 | KLOTZ    | JEFFREY | NA     | NA     | Nursing home  | 33Z302       | 331302     |
| 2   | 1396989059 | 8921259557 | HALLORAN | MARY    | K      | NA     | Nursing home  | 33Z302       | 331302     |
| 3   | 1538173869 | 0547299091 | CHON     | IL      | JUN    | NA     | Nursing home  | 33Z302       | 331302     |
| 4   | 1558659367 | 6709004682 | BANU     | DRAGOS  | NA     | NA     | Nursing home  | 33Z302       | 331302     |

  

That returns more affiliated individual providers that practice in the
Hospital’s nursing home..

  

> An *alphanumeric* CCN represents a sub-unit of the hospital, here a
> nursing home. We would get the same result if we’d set the
> `parent_ccn` argument to the numeric CCN,
> i.e. `affiliations(parent_ccn = 331302)`
