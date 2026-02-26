# Quality Payment Program

``` r
library(provider)
library(future)
library(furrr)
library(dplyr)
library(tidyr)
```

## Quality Payment Reporting

``` r
plan(multisession, workers = 4)
q <- quality_payment_(npi = 1144544834)
plan(sequential)
q
```

    #>   provider key practice state or us territory practice size clinician specialty
    #> 1    000865909                             GA             8 Physician Assistant
    #> 2    000047522                             GA             8 Physician Assistant
    #> 3    000117740                             GA            12 Physician Assistant
    #> 4    000659906                             GA            13 Physician Assistant
    #> 5    000000310                             GA            13 Physician Assistant
    #> 6    000183263                             GA            11 Physician Assistant
    #> 7    000212248                             GA            11 Physician Assistant
    #> 8    000475122                             GA            14 Physician Assistant
    #>   years in medicare        npi engaged participation type medicare patients
    #> 1                 8 1144544834   False              Group              2867
    #> 2                 8 1144544834    True              Group              2731
    #> 3                 8 1144544834    True              Group              3165
    #> 4                 9 1144544834    True              Group              5621
    #> 5                10 1144544834    True              Group              4804
    #> 6                11 1144544834    True              Group              4722
    #> 7                12 1144544834    <NA>               <NA>              4800
    #> 8                13 1144544834    <NA>               <NA>              5100
    #>   allowed charges services opted into mips small practitioner rural clinician
    #> 1         1355375                    False               True           False
    #> 2         1268854        0           False               True           False
    #> 3         1051616        0           False               True           False
    #> 4         2720001    25215           False               True           False
    #> 5         2383127    21667           False               True           False
    #> 6         2270356    19234           False               True           False
    #> 7         2420566    20534           False               <NA>            <NA>
    #> 8         2469303    20892           False               <NA>            <NA>
    #>   hpsa clinician ambulatory surgical center hospital-based clinician
    #> 1          False                      False                    False
    #> 2          False                      False                    False
    #> 3          False                      False                    False
    #> 4           True                      False                    False
    #> 5           True                      False                    False
    #> 6           True                      False                    False
    #> 7           <NA>                       <NA>                     <NA>
    #> 8           <NA>                       <NA>                     <NA>
    #>   non-patient facing facility-based extreme hardship final score
    #> 1              False          False            False       40.15
    #> 2              False          False            False       62.94
    #> 3              False          False            False        64.9
    #> 4              False          False            False       94.63
    #> 5              False          False            False         100
    #> 6              False          False            False         100
    #> 7               <NA>           <NA>             <NA>       84.65
    #> 8               <NA>           <NA>             <NA>       77.03
    #>   payment adjustment percentage complex patient bonus extreme hardship quality
    #> 1                          0.11                                          False
    #> 2                          0.18                  1.46                    False
    #> 3                          0.18                   1.6                    False
    #> 4                          1.43                  1.54                    False
    #> 5                          1.87                  2.78                    False
    #> 6                          2.34                  2.66                    False
    #> 7                          0.86                     0                     <NA>
    #> 8                          0.18                     0                     <NA>
    #>   quality category score quality improvement bonus quality bonus
    #> 1                   41.9                         0          True
    #> 2                     76                      6.54          True
    #> 3                   74.6                      1.83          True
    #> 4                  96.71                         0          True
    #> 5                    100                      3.38          True
    #> 6                    100                      0.08          True
    #> 7                  91.34                      <NA>          <NA>
    #> 8                  95.71                      <NA>          <NA>
    #>   quality measure id 1 quality measure score 1 quality measure id 2
    #> 1                  111                     5.5                  110
    #> 2                  431                     8.9                  337
    #> 3                  111                     9.4                  138
    #> 4                  410                      10                  337
    #> 5                  337                      10                  138
    #> 6                  337                      10                  137
    #> 7                  137                      10                  410
    #> 8                  137                      10                  238
    #>   quality measure score 2 quality measure id 3 quality measure score 3
    #> 1                     3.7                  138                       3
    #> 2                     8.3                  111                     7.6
    #> 3                       7                   48                     5.8
    #> 4                      10                  431                     6.1
    #> 5                      10                  137                      10
    #> 6                      10                  238                      10
    #> 7                      10                  138                       7
    #> 8                      10                  410                      10
    #>   quality measure id 4 quality measure score 4 quality measure id 5
    #> 1                  265                       3                   47
    #> 2                  138                     3.9                  130
    #> 3                  431                     5.7                   47
    #> 4                   47                     5.2                  238
    #> 5                  410                      10                  238
    #> 6                  410                      10                  265
    #> 7                  265                       7                  394
    #> 8                  138                       7                  485
    #>   quality measure score 5 quality measure id 6 quality measure score 6
    #> 1                       3                  137                       3
    #> 2                     3.2                  110                     3.2
    #> 3                     5.6                  137                     5.5
    #> 4                     4.5                  111                     4.3
    #> 5                     6.9                  431                     6.7
    #> 6                       7                  138                       7
    #> 7                     5.7                  238                       0
    #> 8                       7                  486                       7
    #>   quality measure id 7 quality measure score 7 quality measure id 8
    #> 1                                                                  
    #> 2                                                                  
    #> 3                                                                  
    #> 4                                                                  
    #> 5                                                                  
    #> 6                                                                  
    #> 7                                                                  
    #> 8                                                                  
    #>   quality measure score 8 quality measure id 9 quality measure score 9
    #> 1                                                                     
    #> 2                                                                     
    #> 3                                                                     
    #> 4                                                                     
    #> 5                                                                     
    #> 6                                                                     
    #> 7                                                                     
    #> 8                                                                     
    #>   quality measure id 10 quality measure score 10
    #> 1                                               
    #> 2                                               
    #> 3                                               
    #> 4                                               
    #> 5                                               
    #> 6                                               
    #> 7                                               
    #> 8                                               
    #>   promoting interoperability (pi) category score extreme hardship pi
    #> 1                                              0               False
    #> 2                                              0               False
    #> 3                                              0               False
    #> 4                                              0               False
    #> 5                                              0               False
    #> 6                                              0               False
    #> 7                                              0                <NA>
    #> 8                                              0                <NA>
    #>   pi hardship pi reweighting pi bonus pi cehrt id pi measure id 1
    #> 1       False          False    False                            
    #> 2       False          False    False                            
    #> 3       False          False    False                            
    #> 4        True           True    False                            
    #> 5        True           True    False                            
    #> 6        True           True    False                            
    #> 7        <NA>           <NA>     <NA>        <NA>                
    #> 8        <NA>           <NA>     <NA>        <NA>                
    #>   pi measure score 1 pi measure id 2 pi measure score 2 pi measure id 3
    #> 1                                                                      
    #> 2                                                                      
    #> 3                                                                      
    #> 4                                                                      
    #> 5                                                                      
    #> 6                                                                      
    #> 7                                                                      
    #> 8                                                                      
    #>   pi measure score 3 pi measure id 4 pi measure score 4 pi measure id 5
    #> 1                                                                      
    #> 2                                                                      
    #> 3                                                                      
    #> 4                                                                      
    #> 5                                                                      
    #> 6                                                                      
    #> 7                                                                      
    #> 8                                                                      
    #>   pi measure score 5 pi measure id 6 pi measure score 6 pi measure id 7
    #> 1                                                                      
    #> 2                                                                      
    #> 3                                                                      
    #> 4                                                                      
    #> 5                                                                      
    #> 6                                                                      
    #> 7                                                                      
    #> 8                                                                      
    #>   pi measure score 7 pi measure id 8 pi measure score 8 pi measure id 9
    #> 1                                                                      
    #> 2                                                                      
    #> 3                                                                      
    #> 4                                                                      
    #> 5                                                                      
    #> 6                                                                      
    #> 7                                                                      
    #> 8                                                                      
    #>   pi measure score 9 pi measure id 10 pi measure score 10 pi measure id 11
    #> 1                                                                         
    #> 2                                                                         
    #> 3                                                                         
    #> 4                                                                         
    #> 5                                                                         
    #> 6                                                                         
    #> 7                                                                         
    #> 8                                                                         
    #>   pi measure score 11 ia score extreme hardship ia ia study ia measure id 1
    #> 1                           40               False    False         IA_BE_6
    #> 2                           40               False    False         IA_BE_6
    #> 3                           40               False    False        IA_EPA_1
    #> 4                           40               False    False        IA_EPA_1
    #> 5                           40               False    False         IA_BE_6
    #> 6                           40               False    False         IA_BE_6
    #> 7                         <NA>                <NA>     <NA>        IA_EPA_1
    #> 8                         <NA>                <NA>     <NA>         IA_BE_4
    #>   ia measure score 1 ia measure id 2 ia measure score 2 ia measure id 3
    #> 1                 40        IA_AHE_1                 40                
    #> 2                 40        IA_EPA_1                 40                
    #> 3                 40         IA_BE_6                 40                
    #> 4                 40         IA_BE_6                 40                
    #> 5                 40        IA_EPA_1                 40                
    #> 6                 40        IA_EPA_1                 40                
    #> 7                 40        IA_EPA_3                 20                
    #> 8                 20        IA_EPA_3                 20                
    #>   ia measure score 3 ia measure id 4 ia measure score 4 cost score
    #> 1                                                                 
    #> 2                                                             34.7
    #> 3                                                             60.2
    #> 4                                                            69.27
    #> 5                                                                0
    #> 6                                                                0
    #> 7                                                             <NA>
    #> 8                                                             <NA>
    #>   extreme hardship cost cost measure id 1 cost measure score 1
    #> 1                 False            TPCC_1                  4.6
    #> 2                 False            TPCC_1                  3.5
    #> 3                 False            TPCC_1                    6
    #> 4                 False            TPCC_1                  6.9
    #> 5                 False                                       
    #> 6                 False                                       
    #> 7                  <NA>            TPCC_1                 <NA>
    #> 8                  <NA>         COST_MR_1                 <NA>
    #>   cost measure id 2 cost measure score 2      clinician type non-reporting
    #> 1                                                       <NA>          <NA>
    #> 2                                                       <NA>          <NA>
    #> 3                                                       <NA>          <NA>
    #> 4                                                       <NA>          <NA>
    #> 5                                                       <NA>          <NA>
    #> 6                                                       <NA>          <NA>
    #> 7         COST_MR_1                 <NA> Physician Assistant         False
    #> 8                                   <NA> Physician Assistant         False
    #>   participation option small practice status rural status
    #> 1                 <NA>                  <NA>         <NA>
    #> 2                 <NA>                  <NA>         <NA>
    #> 3                 <NA>                  <NA>         <NA>
    #> 4                 <NA>                  <NA>         <NA>
    #> 5                 <NA>                  <NA>         <NA>
    #> 6                 <NA>                  <NA>         <NA>
    #> 7                Group                  True        False
    #> 8                Group                  True        False
    #>   health professional shortage area status
    #> 1                                     <NA>
    #> 2                                     <NA>
    #> 3                                     <NA>
    #> 4                                     <NA>
    #> 5                                     <NA>
    #> 6                                     <NA>
    #> 7                                     True
    #> 8                                     True
    #>   ambulatory surgical center-based status hospital-based status
    #> 1                                    <NA>                  <NA>
    #> 2                                    <NA>                  <NA>
    #> 3                                    <NA>                  <NA>
    #> 4                                    <NA>                  <NA>
    #> 5                                    <NA>                  <NA>
    #> 6                                    <NA>                  <NA>
    #> 7                                   False                 False
    #> 8                                   False                 False
    #>   non-patient facing status facility-based status dual eligibility ratio
    #> 1                      <NA>                  <NA>                   <NA>
    #> 2                      <NA>                  <NA>                   <NA>
    #> 3                      <NA>                  <NA>                   <NA>
    #> 4                      <NA>                  <NA>                   <NA>
    #> 5                      <NA>                  <NA>                   <NA>
    #> 6                      <NA>                  <NA>                   <NA>
    #> 7                     False                 False                   0.07
    #> 8                     False                 False                   0.07
    #>   safety-net status extreme uncontrollable circumstance (euc)
    #> 1              <NA>                                      <NA>
    #> 2              <NA>                                      <NA>
    #> 3              <NA>                                      <NA>
    #> 4              <NA>                                      <NA>
    #> 5              <NA>                                      <NA>
    #> 6              <NA>                                      <NA>
    #> 7             False                                     False
    #> 8             False                                     False
    #>   quality reweighting (euc) quality improvement score small practice bonus
    #> 1                      <NA>                      <NA>                 <NA>
    #> 2                      <NA>                      <NA>                 <NA>
    #> 3                      <NA>                      <NA>                 <NA>
    #> 4                      <NA>                      <NA>                 <NA>
    #> 5                      <NA>                      <NA>                 <NA>
    #> 6                      <NA>                      <NA>                 <NA>
    #> 7                     False                         0                    6
    #> 8                     False                      0.71                    6
    #>   quality measure collection type 1 quality measure collection type 2
    #> 1                              <NA>                              <NA>
    #> 2                              <NA>                              <NA>
    #> 3                              <NA>                              <NA>
    #> 4                              <NA>                              <NA>
    #> 5                              <NA>                              <NA>
    #> 6                              <NA>                              <NA>
    #> 7                          MIPS CQM                          MIPS CQM
    #> 8                                                                    
    #>   quality measure collection type 3 quality measure collection type 4
    #> 1                              <NA>                              <NA>
    #> 2                              <NA>                              <NA>
    #> 3                              <NA>                              <NA>
    #> 4                              <NA>                              <NA>
    #> 5                              <NA>                              <NA>
    #> 6                              <NA>                              <NA>
    #> 7                          MIPS CQM                          MIPS CQM
    #> 8                                                                    
    #>   quality measure collection type 5 quality measure collection type 6
    #> 1                              <NA>                              <NA>
    #> 2                              <NA>                              <NA>
    #> 3                              <NA>                              <NA>
    #> 4                              <NA>                              <NA>
    #> 5                              <NA>                              <NA>
    #> 6                              <NA>                              <NA>
    #> 7                          MIPS CQM                          MIPS CQM
    #> 8                                                                    
    #>   quality measure collection type 7 quality measure collection type 8
    #> 1                              <NA>                              <NA>
    #> 2                              <NA>                              <NA>
    #> 3                              <NA>                              <NA>
    #> 4                              <NA>                              <NA>
    #> 5                              <NA>                              <NA>
    #> 6                              <NA>                              <NA>
    #> 7                                                                    
    #> 8                                                                    
    #>   quality measure collection type 9 quality measure collection type 10
    #> 1                              <NA>                               <NA>
    #> 2                              <NA>                               <NA>
    #> 3                              <NA>                               <NA>
    #> 4                              <NA>                               <NA>
    #> 5                              <NA>                               <NA>
    #> 6                              <NA>                               <NA>
    #> 7                                                                     
    #> 8                                                                     
    #>   quality measure id 11 quality measure collection type 11
    #> 1                  <NA>                               <NA>
    #> 2                  <NA>                               <NA>
    #> 3                  <NA>                               <NA>
    #> 4                  <NA>                               <NA>
    #> 5                  <NA>                               <NA>
    #> 6                  <NA>                               <NA>
    #> 7                                                         
    #> 8                                                         
    #>   quality measure score 11 quality measure id 12
    #> 1                     <NA>                  <NA>
    #> 2                     <NA>                  <NA>
    #> 3                     <NA>                  <NA>
    #> 4                     <NA>                  <NA>
    #> 5                     <NA>                  <NA>
    #> 6                     <NA>                  <NA>
    #> 7                                               
    #> 8                                               
    #>   quality measure collection type 12 quality measure score 12
    #> 1                               <NA>                     <NA>
    #> 2                               <NA>                     <NA>
    #> 3                               <NA>                     <NA>
    #> 4                               <NA>                     <NA>
    #> 5                               <NA>                     <NA>
    #> 6                               <NA>                     <NA>
    #> 7                                                            
    #> 8                                                            
    #>   pi reweighting (euc) pi reweighting (hardship exception)
    #> 1                 <NA>                                <NA>
    #> 2                 <NA>                                <NA>
    #> 3                 <NA>                                <NA>
    #> 4                 <NA>                                <NA>
    #> 5                 <NA>                                <NA>
    #> 6                 <NA>                                <NA>
    #> 7                False                               False
    #> 8                False                               False
    #>   pi reweighting (special status or clinician type) cehrt id pi measure type 1
    #> 1                                              <NA>     <NA>              <NA>
    #> 2                                              <NA>     <NA>              <NA>
    #> 3                                              <NA>     <NA>              <NA>
    #> 4                                              <NA>     <NA>              <NA>
    #> 5                                              <NA>     <NA>              <NA>
    #> 6                                              <NA>     <NA>              <NA>
    #> 7                                              True                           
    #> 8                                              True                           
    #>   pi measure type 2 pi measure type 3 pi measure type 4 pi measure type 5
    #> 1              <NA>              <NA>              <NA>              <NA>
    #> 2              <NA>              <NA>              <NA>              <NA>
    #> 3              <NA>              <NA>              <NA>              <NA>
    #> 4              <NA>              <NA>              <NA>              <NA>
    #> 5              <NA>              <NA>              <NA>              <NA>
    #> 6              <NA>              <NA>              <NA>              <NA>
    #> 7                                                                        
    #> 8                                                                        
    #>   pi measure type 6 pi measure type 7 pi measure type 8 pi measure type 9
    #> 1              <NA>              <NA>              <NA>              <NA>
    #> 2              <NA>              <NA>              <NA>              <NA>
    #> 3              <NA>              <NA>              <NA>              <NA>
    #> 4              <NA>              <NA>              <NA>              <NA>
    #> 5              <NA>              <NA>              <NA>              <NA>
    #> 6              <NA>              <NA>              <NA>              <NA>
    #> 7                                                                        
    #> 8                                                                        
    #>   pi measure type 10 pi measure type 11
    #> 1               <NA>               <NA>
    #> 2               <NA>               <NA>
    #> 3               <NA>               <NA>
    #> 4               <NA>               <NA>
    #> 5               <NA>               <NA>
    #> 6               <NA>               <NA>
    #> 7                                      
    #> 8                                      
    #>   improvement activities (ia) category score ia reweighting (euc) ia credit
    #> 1                                       <NA>                 <NA>      <NA>
    #> 2                                       <NA>                 <NA>      <NA>
    #> 3                                       <NA>                 <NA>      <NA>
    #> 4                                       <NA>                 <NA>      <NA>
    #> 5                                       <NA>                 <NA>      <NA>
    #> 6                                       <NA>                 <NA>      <NA>
    #> 7                                         40                False     False
    #> 8                                         40                False     False
    #>   cost category score cost reweighting (euc) cost measure achievement points 1
    #> 1                <NA>                   <NA>                              <NA>
    #> 2                <NA>                   <NA>                              <NA>
    #> 3                <NA>                   <NA>                              <NA>
    #> 4                <NA>                   <NA>                              <NA>
    #> 5                <NA>                   <NA>                              <NA>
    #> 6                <NA>                   <NA>                              <NA>
    #> 7              60.375                  False                               9.1
    #> 8               29.16                  False                               2.9
    #>   cost measure achievement points 2 cost measure id 3
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                              <NA>              <NA>
    #> 7                               2.9                  
    #> 8                                                    
    #>   cost measure achievement points 3 cost measure id 4
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                              <NA>              <NA>
    #> 7                                                    
    #> 8                                                    
    #>   cost measure achievement points 4 cost measure id 5
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                              <NA>              <NA>
    #> 7                                                    
    #> 8                                                    
    #>   cost measure achievement points 5 cost measure id 6
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                              <NA>              <NA>
    #> 7                                                    
    #> 8                                                    
    #>   cost measure achievement points 6 cost measure id 7
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                              <NA>              <NA>
    #> 7                                                    
    #> 8                                                    
    #>   cost measure achievement points 7 cost measure id 8
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                              <NA>              <NA>
    #> 7                                                    
    #> 8                                                    
    #>   cost measure achievement points 8 cost measure id 9
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                              <NA>              <NA>
    #> 7                                                    
    #> 8                                                    
    #>   cost measure achievement points 9 cost measure id 10
    #> 1                              <NA>               <NA>
    #> 2                              <NA>               <NA>
    #> 3                              <NA>               <NA>
    #> 4                              <NA>               <NA>
    #> 5                              <NA>               <NA>
    #> 6                              <NA>               <NA>
    #> 7                                                     
    #> 8                                                     
    #>   cost measure achievement points 10 cost measure id 11
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 11 cost measure id 12
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 12 cost measure id 13
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 13 cost measure id 14
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 14 cost measure id 15
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 15 cost measure id 16
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 16 cost measure id 17
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 17 cost measure id 18
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 18 cost measure id 19
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 19 cost measure id 20
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 20 cost measure id 21
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 21 cost measure id 22
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 22 cost measure id 23
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 23 cost measure id 24
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                               <NA>               <NA>
    #> 7                                                      
    #> 8                                                      
    #>   cost measure achievement points 24 reporting option mips value pathway id
    #> 1                               <NA>             <NA>                  <NA>
    #> 2                               <NA>             <NA>                  <NA>
    #> 3                               <NA>             <NA>                  <NA>
    #> 4                               <NA>             <NA>                  <NA>
    #> 5                               <NA>             <NA>                  <NA>
    #> 6                               <NA>             <NA>                  <NA>
    #> 7                                                <NA>                  <NA>
    #> 8                                    Traditional MIPS                      
    #>   mips value pathway title received facility score quality category weight
    #> 1                     <NA>                    <NA>                    <NA>
    #> 2                     <NA>                    <NA>                    <NA>
    #> 3                     <NA>                    <NA>                    <NA>
    #> 4                     <NA>                    <NA>                    <NA>
    #> 5                     <NA>                    <NA>                    <NA>
    #> 6                     <NA>                    <NA>                    <NA>
    #> 7                     <NA>                    <NA>                    <NA>
    #> 8                                            False                     0.4
    #>   promoting interoperability (pi) category weight pi measure id 12
    #> 1                                            <NA>             <NA>
    #> 2                                            <NA>             <NA>
    #> 3                                            <NA>             <NA>
    #> 4                                            <NA>             <NA>
    #> 5                                            <NA>             <NA>
    #> 6                                            <NA>             <NA>
    #> 7                                            <NA>             <NA>
    #> 8                                               0                 
    #>   pi measure type 12 pi measure score 12 pi measure id 13 pi measure type 13
    #> 1               <NA>                <NA>             <NA>               <NA>
    #> 2               <NA>                <NA>             <NA>               <NA>
    #> 3               <NA>                <NA>             <NA>               <NA>
    #> 4               <NA>                <NA>             <NA>               <NA>
    #> 5               <NA>                <NA>             <NA>               <NA>
    #> 6               <NA>                <NA>             <NA>               <NA>
    #> 7               <NA>                <NA>             <NA>               <NA>
    #> 8                                                                           
    #>   pi measure score 13 pi measure id 14 pi measure type 14 pi measure score 14
    #> 1                <NA>             <NA>               <NA>                <NA>
    #> 2                <NA>             <NA>               <NA>                <NA>
    #> 3                <NA>             <NA>               <NA>                <NA>
    #> 4                <NA>             <NA>               <NA>                <NA>
    #> 5                <NA>             <NA>               <NA>                <NA>
    #> 6                <NA>             <NA>               <NA>                <NA>
    #> 7                <NA>             <NA>               <NA>                <NA>
    #> 8                                                                            
    #>   pi measure id 15 pi measure type 15 pi measure score 15 pi measure id 16
    #> 1             <NA>               <NA>                <NA>             <NA>
    #> 2             <NA>               <NA>                <NA>             <NA>
    #> 3             <NA>               <NA>                <NA>             <NA>
    #> 4             <NA>               <NA>                <NA>             <NA>
    #> 5             <NA>               <NA>                <NA>             <NA>
    #> 6             <NA>               <NA>                <NA>             <NA>
    #> 7             <NA>               <NA>                <NA>             <NA>
    #> 8                                                                         
    #>   pi measure type 16 pi measure score 16 pi measure id 17 pi measure type 17
    #> 1               <NA>                <NA>             <NA>               <NA>
    #> 2               <NA>                <NA>             <NA>               <NA>
    #> 3               <NA>                <NA>             <NA>               <NA>
    #> 4               <NA>                <NA>             <NA>               <NA>
    #> 5               <NA>                <NA>             <NA>               <NA>
    #> 6               <NA>                <NA>             <NA>               <NA>
    #> 7               <NA>                <NA>             <NA>               <NA>
    #> 8                                                                           
    #>   pi measure score 17 pi measure id 18 pi measure type 18 pi measure score 18
    #> 1                <NA>             <NA>               <NA>                <NA>
    #> 2                <NA>             <NA>               <NA>                <NA>
    #> 3                <NA>             <NA>               <NA>                <NA>
    #> 4                <NA>             <NA>               <NA>                <NA>
    #> 5                <NA>             <NA>               <NA>                <NA>
    #> 6                <NA>             <NA>               <NA>                <NA>
    #> 7                <NA>             <NA>               <NA>                <NA>
    #> 8                                                                            
    #>   pi measure id 19 pi measure type 19 pi measure score 19 pi measure id 20
    #> 1             <NA>               <NA>                <NA>             <NA>
    #> 2             <NA>               <NA>                <NA>             <NA>
    #> 3             <NA>               <NA>                <NA>             <NA>
    #> 4             <NA>               <NA>                <NA>             <NA>
    #> 5             <NA>               <NA>                <NA>             <NA>
    #> 6             <NA>               <NA>                <NA>             <NA>
    #> 7             <NA>               <NA>                <NA>             <NA>
    #> 8                                                                         
    #>   pi measure type 20 pi measure score 20 pi measure id 21 pi measure type 21
    #> 1               <NA>                <NA>             <NA>               <NA>
    #> 2               <NA>                <NA>             <NA>               <NA>
    #> 3               <NA>                <NA>             <NA>               <NA>
    #> 4               <NA>                <NA>             <NA>               <NA>
    #> 5               <NA>                <NA>             <NA>               <NA>
    #> 6               <NA>                <NA>             <NA>               <NA>
    #> 7               <NA>                <NA>             <NA>               <NA>
    #> 8                                                                           
    #>   pi measure score 21 improvement activities (ia) category weight
    #> 1                <NA>                                        <NA>
    #> 2                <NA>                                        <NA>
    #> 3                <NA>                                        <NA>
    #> 4                <NA>                                        <NA>
    #> 5                <NA>                                        <NA>
    #> 6                <NA>                                        <NA>
    #> 7                <NA>                                        <NA>
    #> 8                                                             0.3
    #>   cost improvement score cost category weight
    #> 1                   <NA>                 <NA>
    #> 2                   <NA>                 <NA>
    #> 3                   <NA>                 <NA>
    #> 4                   <NA>                 <NA>
    #> 5                   <NA>                 <NA>
    #> 6                   <NA>                 <NA>
    #> 7                   <NA>                 <NA>
    #> 8                      0                  0.3

## Grouping

``` r
q |> 
  select(year, 
         participation_type,
         org_name,
         org_size,
         beneficiaries,
         services,
         charges,
         final_score,
         pay_adjust,
         ind_lvt_status_desc)
```

    #> Error in `select()`:
    #> ! Can't select columns that don't exist.
    #> ✖ Column `year` doesn't exist.

### Special Statuses

``` r
select(q, year, participation_type, org_name, org_size, qpp_status) |> 
  unnest(qpp_status)
```

    #> Error in `select()`:
    #> ! Can't select columns that don't exist.
    #> ✖ Column `year` doesn't exist.

  

``` r
select(q, year, participation_type, org_name, org_size, qpp_status) |> 
  unnest(qpp_status) |> 
  count(org_name, qualified, sort = TRUE)
```

    #> Error in `select()`:
    #> ! Can't select columns that don't exist.
    #> ✖ Column `year` doesn't exist.

  

### Individual Category Measures

``` r
select(q, year, participation_type, org_name, org_size, qpp_measures) |>
  unnest(qpp_measures)
```

    #> Error in `select()`:
    #> ! Can't select columns that don't exist.
    #> ✖ Column `year` doesn't exist.

  

``` r
select(q, year, participation_type, org_name, org_size, qpp_measures) |>
  unnest(qpp_measures) |> 
  count(year, org_name, category, sort = TRUE)
```

    #> Error in `select()`:
    #> ! Can't select columns that don't exist.
    #> ✖ Column `year` doesn't exist.

  

``` r
plan(multisession, workers = 4)
qq <- quality_payment_(npi = 1043477615)
plan(sequential)
qq
```

    #>   provider key practice state or us territory practice size
    #> 1    000962209                             PA          1394
    #> 2    000169605                             PA          1297
    #> 3    000350199                             PA          1344
    #> 4    000402699                             PA          1440
    #> 5    000066744                             PA          1940
    #> 6    000021992                             PA          1518
    #> 7    000131692                             MD          1572
    #>         clinician specialty years in medicare        npi engaged
    #> 1 Cardiac Electrophysiology                 5 1043477615   False
    #> 2 Cardiac Electrophysiology                 5 1043477615    True
    #> 3 Cardiac Electrophysiology                 6 1043477615    True
    #> 4 Cardiac Electrophysiology                 7 1043477615    True
    #> 5 Cardiac Electrophysiology                 8 1043477615    True
    #> 6 Cardiac Electrophysiology                 9 1043477615    <NA>
    #> 7 Cardiac Electrophysiology                10 1043477615    <NA>
    #>   participation type medicare patients allowed charges services opted into mips
    #> 1           MIPS APM             43007        36391760                    False
    #> 2           MIPS APM             41034        35008312        0           False
    #> 3           MIPS APM             42222        36899498   415298           False
    #> 4           MIPS APM             39624        33458425   374278           False
    #> 5           MIPS APM             41404        35627551   403720           False
    #> 6               <NA>             41539        34056294   388535           False
    #> 7               <NA>             42490        33448639   386736           False
    #>   small practitioner rural clinician hpsa clinician ambulatory surgical center
    #> 1                              False          False                      False
    #> 2              False           False          False                      False
    #> 3              False           False          False                      False
    #> 4              False           False          False                      False
    #> 5              False           False          False                      False
    #> 6               <NA>            <NA>           <NA>                       <NA>
    #> 7               <NA>            <NA>           <NA>                       <NA>
    #>   hospital-based clinician non-patient facing facility-based extreme hardship
    #> 1                    False              False          False            False
    #> 2                    False              False          False            False
    #> 3                    False              False          False            False
    #> 4                     True              False          False            False
    #> 5                     True              False          False            False
    #> 6                     <NA>               <NA>           <NA>             <NA>
    #> 7                     <NA>               <NA>           <NA>             <NA>
    #>   final score payment adjustment percentage complex patient bonus
    #> 1       97.09                          1.72                      
    #> 2         100                          1.68                     3
    #> 3       95.12                          1.46                     3
    #> 4        96.7                          1.48                   5.7
    #> 5       97.25                          1.94                  5.64
    #> 6       80.81                          0.52                     0
    #> 7       71.79                         -0.39                     0
    #>   extreme hardship quality quality category score quality improvement bonus
    #> 1                    False                   95.5                         0
    #> 2                    False                    100                      0.32
    #> 3                    False                    100                         0
    #> 4                    False                    100                         0
    #> 5                    False                   83.5                         0
    #> 6                     <NA>                     75                      <NA>
    #> 7                     <NA>                  48.32                      <NA>
    #>   quality bonus quality measure id 1 quality measure score 1
    #> 1          True                  204                      10
    #> 2          True               ACO321                    11.2
    #> 3          True               ACO321                    11.1
    #> 4          True                  318                      10
    #> 5          True                  318                     9.8
    #> 6          <NA>                  318                      10
    #> 7          <NA>                  134                       7
    #>   quality measure id 2 quality measure score 2 quality measure id 3
    #> 1                  318                      10                  111
    #> 2          DMCOMPOSITE                      10                  204
    #> 3                  318                      10                    1
    #> 4                  001                     9.2                  113
    #> 5                  001                     9.5                  110
    #> 6                  001                     9.6                  134
    #> 7                  001                     5.7                  309
    #>   quality measure score 3 quality measure id 4 quality measure score 4
    #> 1                     9.5                  110                     9.4
    #> 2                      10                  318                     9.8
    #> 3                     9.6                  112                     8.5
    #> 4                     9.2                  226                     9.2
    #> 5                       9                  112                     8.3
    #> 6                     9.5                  479                     9.3
    #> 7                     5.2                  318                     5.2
    #>   quality measure id 5 quality measure score 5 quality measure id 6
    #> 1          DMCOMPOSITE                     8.3                  112
    #> 2                  111                     9.3                  128
    #> 3                  113                     8.4                  236
    #> 4                  112                     8.3                  110
    #> 5                  113                     8.3                  236
    #> 6                  112                     8.9                  113
    #> 7                  236                     5.2                  479
    #>   quality measure score 6 quality measure id 7 quality measure score 7
    #> 1                     8.2                  226                     8.2
    #> 2                     9.3                  134                     8.3
    #> 3                     8.1                                             
    #> 4                     8.1                  236                     7.9
    #> 5                     7.4                  479                     6.6
    #> 6                     8.7                  110                     8.6
    #> 7                       5                  492                     4.8
    #>   quality measure id 8 quality measure score 8 quality measure id 9
    #> 1                  113                     8.2                  236
    #> 2                  236                     8.3                  113
    #> 3                                                                  
    #> 4                  134                       0                     
    #> 5                  321                     6.6                  226
    #> 6                  236                     7.2                  226
    #> 7                  321                     4.1                  484
    #>   quality measure score 9 quality measure id 10 quality measure score 10
    #> 1                     7.8                   134                      7.2
    #> 2                       8                   110                      7.6
    #> 3                                                                       
    #> 4                                                                       
    #> 5                       5                  MCC1                      3.0
    #> 6                     6.8                   321                      5.0
    #> 7                     3.1                   480                        3
    #>   promoting interoperability (pi) category score extreme hardship pi
    #> 1                                          97.78               False
    #> 2                                            100               False
    #> 3                                          73.74               False
    #> 4                                          69.99               False
    #> 5                                          99.55               False
    #> 6                                            100                <NA>
    #> 7                                            100                <NA>
    #>   pi hardship pi reweighting pi bonus pi cehrt id pi measure id 1
    #> 1        True           True    False                            
    #> 2       False          False    False                            
    #> 3       False          False    False                            
    #> 4       False           True    False                            
    #> 5       False           True    False                            
    #> 6        <NA>           <NA>     <NA>        <NA>        PI_HIE_5
    #> 7        <NA>           <NA>     <NA>        <NA>        PI_HIE_5
    #>   pi measure score 1 pi measure id 2 pi measure score 2 pi measure id 3
    #> 1                                                                      
    #> 2                                                                      
    #> 3                                                                      
    #> 4                                                                      
    #> 5                                                                      
    #> 6                 40        PI_PEA_1                 39         PI_EP_1
    #> 7                 30        PI_PEA_1                 25     PI_PHCDRR_1
    #>   pi measure score 3 pi measure id 4 pi measure score 4 pi measure id 5
    #> 1                                                                      
    #> 2                                                                      
    #> 3                                                                      
    #> 4                                                                      
    #> 5                                                                      
    #> 6                 10     PI_PHCDRR_1                  5     PI_PHCDRR_3
    #> 7                 12     PI_PHCDRR_3                 12         PI_EP_1
    #>   pi measure score 5 pi measure id 6 pi measure score 6 pi measure id 7
    #> 1                                                                      
    #> 2                                                                      
    #> 3                                                                      
    #> 4                                                                      
    #> 5                                                                      
    #> 6                  5     PI_PHCDRR_4                  5                
    #> 7                 10         PI_EP_2                 10     PI_INFBLO_1
    #>   pi measure score 7 pi measure id 8 pi measure score 8 pi measure id 9
    #> 1                                                                      
    #> 2                                                                      
    #> 3                                                                      
    #> 4                                                                      
    #> 5                                                                      
    #> 6                                                                      
    #> 7                  0     PI_ONCACB_1                  0     PI_ONCDIR_1
    #>   pi measure score 9 pi measure id 10 pi measure score 10 pi measure id 11
    #> 1                                                                         
    #> 2                                                                         
    #> 3                                                                         
    #> 4                                                                         
    #> 5                                                                         
    #> 6                                                                         
    #> 7                  0 PI_PHCDRR_1_PROD                   0 PI_PHCDRR_3_PROD
    #>   pi measure score 11 ia score extreme hardship ia ia study ia measure id 1
    #> 1                           40               False    False                
    #> 2                           40               False    False                
    #> 3                           40               False    False                
    #> 4                           40               False    False                
    #> 5                           40               False    False                
    #> 6                         <NA>                <NA>     <NA>        IA_EPA_1
    #> 7                   0     <NA>                <NA>     <NA>        IA_EPA_1
    #>   ia measure score 1 ia measure id 2 ia measure score 2 ia measure id 3
    #> 1                                                                      
    #> 2                                                                      
    #> 3                                                                      
    #> 4                                                                      
    #> 5                                                                      
    #> 6                 20         IA_PM_2                 20       IA_PSPA_6
    #> 7                 20        IA_EPA_3                 10        IA_PM_12
    #>   ia measure score 3 ia measure id 4 ia measure score 4 cost score
    #> 1                                                                 
    #> 2                                                                0
    #> 3                                                                0
    #> 4                                                                0
    #> 5                                                                0
    #> 6                 20        IA_EPA_2                 10       <NA>
    #> 7                 10                                          <NA>
    #>   extreme hardship cost cost measure id 1 cost measure score 1
    #> 1                 False                                       
    #> 2                 False                                       
    #> 3                 False                                       
    #> 4                 False                                       
    #> 5                 False                                       
    #> 6                  <NA>          COST_S_1                 <NA>
    #> 7                  <NA>       COST_CCLI_1                 <NA>
    #>   cost measure id 2 cost measure score 2     clinician type non-reporting
    #> 1                                                      <NA>          <NA>
    #> 2                                                      <NA>          <NA>
    #> 3                                                      <NA>          <NA>
    #> 4                                                      <NA>          <NA>
    #> 5                                                      <NA>          <NA>
    #> 6     COST_NECABG_1                 <NA> Doctor of Medicine         False
    #> 7        COST_LGH_1                 <NA> Doctor of Medicine         False
    #>   participation option small practice status rural status
    #> 1                 <NA>                  <NA>         <NA>
    #> 2                 <NA>                  <NA>         <NA>
    #> 3                 <NA>                  <NA>         <NA>
    #> 4                 <NA>                  <NA>         <NA>
    #> 5                 <NA>                  <NA>         <NA>
    #> 6                Group                 False        False
    #> 7                Group                 False        False
    #>   health professional shortage area status
    #> 1                                     <NA>
    #> 2                                     <NA>
    #> 3                                     <NA>
    #> 4                                     <NA>
    #> 5                                     <NA>
    #> 6                                    False
    #> 7                                    False
    #>   ambulatory surgical center-based status hospital-based status
    #> 1                                    <NA>                  <NA>
    #> 2                                    <NA>                  <NA>
    #> 3                                    <NA>                  <NA>
    #> 4                                    <NA>                  <NA>
    #> 5                                    <NA>                  <NA>
    #> 6                                   False                  True
    #> 7                                   False                  True
    #>   non-patient facing status facility-based status dual eligibility ratio
    #> 1                      <NA>                  <NA>                   <NA>
    #> 2                      <NA>                  <NA>                   <NA>
    #> 3                      <NA>                  <NA>                   <NA>
    #> 4                      <NA>                  <NA>                   <NA>
    #> 5                      <NA>                  <NA>                   <NA>
    #> 6                     False                 False                   0.14
    #> 7                     False                 False                   0.13
    #>   safety-net status extreme uncontrollable circumstance (euc)
    #> 1              <NA>                                      <NA>
    #> 2              <NA>                                      <NA>
    #> 3              <NA>                                      <NA>
    #> 4              <NA>                                      <NA>
    #> 5              <NA>                                      <NA>
    #> 6             False                                     False
    #> 7             False                                     False
    #>   quality reweighting (euc) quality improvement score small practice bonus
    #> 1                      <NA>                      <NA>                 <NA>
    #> 2                      <NA>                      <NA>                 <NA>
    #> 3                      <NA>                      <NA>                 <NA>
    #> 4                      <NA>                      <NA>                 <NA>
    #> 5                      <NA>                      <NA>                 <NA>
    #> 6                     False                      0.32                    0
    #> 7                     False                         0                    0
    #>   quality measure collection type 1 quality measure collection type 2
    #> 1                              <NA>                              <NA>
    #> 2                              <NA>                              <NA>
    #> 3                              <NA>                              <NA>
    #> 4                              <NA>                              <NA>
    #> 5                              <NA>                              <NA>
    #> 6         CMS Web Interface Measure         CMS Web Interface Measure
    #> 7                                                                    
    #>   quality measure collection type 3 quality measure collection type 4
    #> 1                              <NA>                              <NA>
    #> 2                              <NA>                              <NA>
    #> 3                              <NA>                              <NA>
    #> 4                              <NA>                              <NA>
    #> 5                              <NA>                              <NA>
    #> 6         CMS Web Interface Measure     Administrative Claims Measure
    #> 7                                                                    
    #>   quality measure collection type 5 quality measure collection type 6
    #> 1                              <NA>                              <NA>
    #> 2                              <NA>                              <NA>
    #> 3                              <NA>                              <NA>
    #> 4                              <NA>                              <NA>
    #> 5                              <NA>                              <NA>
    #> 6         CMS Web Interface Measure         CMS Web Interface Measure
    #> 7                                                                    
    #>   quality measure collection type 7 quality measure collection type 8
    #> 1                              <NA>                              <NA>
    #> 2                              <NA>                              <NA>
    #> 3                              <NA>                              <NA>
    #> 4                              <NA>                              <NA>
    #> 5                              <NA>                              <NA>
    #> 6         CMS Web Interface Measure         CMS Web Interface Measure
    #> 7                                                                    
    #>   quality measure collection type 9 quality measure collection type 10
    #> 1                              <NA>                               <NA>
    #> 2                              <NA>                               <NA>
    #> 3                              <NA>                               <NA>
    #> 4                              <NA>                               <NA>
    #> 5                              <NA>                               <NA>
    #> 6         CMS Web Interface Measure                      CAHPS Measure
    #> 7                                                                     
    #>   quality measure id 11 quality measure collection type 11
    #> 1                  <NA>                               <NA>
    #> 2                  <NA>                               <NA>
    #> 3                  <NA>                               <NA>
    #> 4                  <NA>                               <NA>
    #> 5                  <NA>                               <NA>
    #> 6                   480      Administrative Claims Measure
    #> 7                                                         
    #>   quality measure score 11 quality measure id 12
    #> 1                     <NA>                  <NA>
    #> 2                     <NA>                  <NA>
    #> 3                     <NA>                  <NA>
    #> 4                     <NA>                  <NA>
    #> 5                     <NA>                  <NA>
    #> 6                      3.0                   484
    #> 7                                               
    #>   quality measure collection type 12 quality measure score 12
    #> 1                               <NA>                     <NA>
    #> 2                               <NA>                     <NA>
    #> 3                               <NA>                     <NA>
    #> 4                               <NA>                     <NA>
    #> 5                               <NA>                     <NA>
    #> 6      Administrative Claims Measure                      3.0
    #> 7                                                            
    #>   pi reweighting (euc) pi reweighting (hardship exception)
    #> 1                 <NA>                                <NA>
    #> 2                 <NA>                                <NA>
    #> 3                 <NA>                                <NA>
    #> 4                 <NA>                                <NA>
    #> 5                 <NA>                                <NA>
    #> 6                False                               False
    #> 7                False                               False
    #>   pi reweighting (special status or clinician type)        cehrt id
    #> 1                                              <NA>            <NA>
    #> 2                                              <NA>            <NA>
    #> 3                                              <NA>            <NA>
    #> 4                                              <NA>            <NA>
    #> 5                                              <NA>            <NA>
    #> 6                                              True 0015EWR5PA30U5M
    #> 7                                              True 0015CSZ1D3D119Q
    #>   pi measure type 1 pi measure type 2 pi measure type 3 pi measure type 4
    #> 1              <NA>              <NA>              <NA>              <NA>
    #> 2              <NA>              <NA>              <NA>              <NA>
    #> 3              <NA>              <NA>              <NA>              <NA>
    #> 4              <NA>              <NA>              <NA>              <NA>
    #> 5              <NA>              <NA>              <NA>              <NA>
    #> 6          required          required          required          required
    #> 7          Required          Required          Required          Required
    #>   pi measure type 5 pi measure type 6 pi measure type 7 pi measure type 8
    #> 1              <NA>              <NA>              <NA>              <NA>
    #> 2              <NA>              <NA>              <NA>              <NA>
    #> 3              <NA>              <NA>              <NA>              <NA>
    #> 4              <NA>              <NA>              <NA>              <NA>
    #> 5              <NA>              <NA>              <NA>              <NA>
    #> 6          required             bonus                                    
    #> 7          Required          Required          Required                  
    #>   pi measure type 9 pi measure type 10 pi measure type 11
    #> 1              <NA>               <NA>               <NA>
    #> 2              <NA>               <NA>               <NA>
    #> 3              <NA>               <NA>               <NA>
    #> 4              <NA>               <NA>               <NA>
    #> 5              <NA>               <NA>               <NA>
    #> 6                                                        
    #> 7          Required           Required           Required
    #>   improvement activities (ia) category score ia reweighting (euc) ia credit
    #> 1                                       <NA>                 <NA>      <NA>
    #> 2                                       <NA>                 <NA>      <NA>
    #> 3                                       <NA>                 <NA>      <NA>
    #> 4                                       <NA>                 <NA>      <NA>
    #> 5                                       <NA>                 <NA>      <NA>
    #> 6                                         40                False     False
    #> 7                                         40                False     False
    #>   cost category score cost reweighting (euc) cost measure achievement points 1
    #> 1                <NA>                   <NA>                              <NA>
    #> 2                <NA>                   <NA>                              <NA>
    #> 3                <NA>                   <NA>                              <NA>
    #> 4                <NA>                   <NA>                              <NA>
    #> 5                <NA>                   <NA>                              <NA>
    #> 6             61.0461                  False                                10
    #> 7             57.6377                  False                                10
    #>   cost measure achievement points 2 cost measure id 3
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                               9.6         COST_MR_1
    #> 7                                10     COST_NECABG_1
    #>   cost measure achievement points 3 cost measure id 4
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                               9.2      COST_COPDE_1
    #> 7                                10          COST_S_1
    #>   cost measure achievement points 4 cost measure id 5
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                                 9       COST_CCLI_1
    #> 7                               9.7        COST_IOL_1
    #>   cost measure achievement points 5 cost measure id 6
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                               8.5        COST_IOL_1
    #> 7                               9.4        COST_CRR_1
    #>   cost measure achievement points 6 cost measure id 7
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                               8.5        COST_HAC_1
    #> 7                               8.8       COST_AKID_1
    #>   cost measure achievement points 7 cost measure id 8
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                               8.1        COST_LGH_1
    #> 7                               8.2         COST_MR_1
    #>   cost measure achievement points 8 cost measure id 9
    #> 1                              <NA>              <NA>
    #> 2                              <NA>              <NA>
    #> 3                              <NA>              <NA>
    #> 4                              <NA>              <NA>
    #> 5                              <NA>              <NA>
    #> 6                               7.7       COST_FIHR_1
    #> 7                               7.4      COST_COPDE_1
    #>   cost measure achievement points 9 cost measure id 10
    #> 1                              <NA>               <NA>
    #> 2                              <NA>               <NA>
    #> 3                              <NA>               <NA>
    #> 4                              <NA>               <NA>
    #> 5                              <NA>               <NA>
    #> 6                               7.1       COST_LSFDD_1
    #> 7                               6.7         COST_HAC_1
    #>   cost measure achievement points 10 cost measure id 11
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                7.1        COST_AKID_1
    #> 7                                5.4       COST_RUSST_1
    #>   cost measure achievement points 11 cost measure id 12
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                6.2         COST_CRR_1
    #> 7                                5.4        COST_IHCI_1
    #>   cost measure achievement points 12 cost measure id 13
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                6.2           COST_D_1
    #> 7                                5.3           COST_D_1
    #>   cost measure achievement points 13 cost measure id 14
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                6.1       COST_LPMSM_1
    #> 7                                5.1         COST_SSC_1
    #>   cost measure achievement points 14 cost measure id 15
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                5.0             MSPB_1
    #> 7                                4.5             MSPB_1
    #>   cost measure achievement points 15 cost measure id 16
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                5.0          COST_KA_1
    #> 7                                4.4          COST_KA_1
    #>   cost measure achievement points 16 cost measure id 17
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                4.3         COST_SSC_1
    #> 7                                4.1       COST_ACOPD_1
    #>   cost measure achievement points 17 cost measure id 18
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                3.8       COST_EOPCI_1
    #> 7                                3.6        COST_FIHR_1
    #>   cost measure achievement points 18 cost measure id 19
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                3.8         COST_PHA_1
    #> 7                                3.5         COST_PHA_1
    #>   cost measure achievement points 19 cost measure id 20
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                3.4       COST_RUSST_1
    #> 7                                2.9       COST_LPMSM_1
    #>   cost measure achievement points 20 cost measure id 21
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                3.0        COST_IHCI_1
    #> 7                                2.8             TPCC_1
    #>   cost measure achievement points 21 cost measure id 22
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                2.9             TPCC_1
    #> 7                                  2       COST_LSFDD_1
    #>   cost measure achievement points 22 cost measure id 23
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                2.9       COST_ACOPD_1
    #> 7                                1.9       COST_EOPCI_1
    #>   cost measure achievement points 23 cost measure id 24
    #> 1                               <NA>               <NA>
    #> 2                               <NA>               <NA>
    #> 3                               <NA>               <NA>
    #> 4                               <NA>               <NA>
    #> 5                               <NA>               <NA>
    #> 6                                2.9                   
    #> 7                                1.7                   
    #>   cost measure achievement points 24 reporting option mips value pathway id
    #> 1                               <NA>             <NA>                  <NA>
    #> 2                               <NA>             <NA>                  <NA>
    #> 3                               <NA>             <NA>                  <NA>
    #> 4                               <NA>             <NA>                  <NA>
    #> 5                               <NA>             <NA>                  <NA>
    #> 6                                                <NA>                  <NA>
    #> 7                                    Traditional MIPS                      
    #>   mips value pathway title received facility score quality category weight
    #> 1                     <NA>                    <NA>                    <NA>
    #> 2                     <NA>                    <NA>                    <NA>
    #> 3                     <NA>                    <NA>                    <NA>
    #> 4                     <NA>                    <NA>                    <NA>
    #> 5                     <NA>                    <NA>                    <NA>
    #> 6                     <NA>                    <NA>                    <NA>
    #> 7                                            False                     0.3
    #>   promoting interoperability (pi) category weight pi measure id 12
    #> 1                                            <NA>             <NA>
    #> 2                                            <NA>             <NA>
    #> 3                                            <NA>             <NA>
    #> 4                                            <NA>             <NA>
    #> 5                                            <NA>             <NA>
    #> 6                                            <NA>             <NA>
    #> 7                                            0.25        PI_PPHI_1
    #>   pi measure type 12 pi measure score 12 pi measure id 13 pi measure type 13
    #> 1               <NA>                <NA>             <NA>               <NA>
    #> 2               <NA>                <NA>             <NA>               <NA>
    #> 3               <NA>                <NA>             <NA>               <NA>
    #> 4               <NA>                <NA>             <NA>               <NA>
    #> 5               <NA>                <NA>             <NA>               <NA>
    #> 6               <NA>                <NA>             <NA>               <NA>
    #> 7           Required                   0        PI_PPHI_2           Required
    #>   pi measure score 13 pi measure id 14 pi measure type 14 pi measure score 14
    #> 1                <NA>             <NA>               <NA>                <NA>
    #> 2                <NA>             <NA>               <NA>                <NA>
    #> 3                <NA>             <NA>               <NA>                <NA>
    #> 4                <NA>             <NA>               <NA>                <NA>
    #> 5                <NA>             <NA>               <NA>                <NA>
    #> 6                <NA>             <NA>               <NA>                <NA>
    #> 7                   0                                                        
    #>   pi measure id 15 pi measure type 15 pi measure score 15 pi measure id 16
    #> 1             <NA>               <NA>                <NA>             <NA>
    #> 2             <NA>               <NA>                <NA>             <NA>
    #> 3             <NA>               <NA>                <NA>             <NA>
    #> 4             <NA>               <NA>                <NA>             <NA>
    #> 5             <NA>               <NA>                <NA>             <NA>
    #> 6             <NA>               <NA>                <NA>             <NA>
    #> 7                                                                         
    #>   pi measure type 16 pi measure score 16 pi measure id 17 pi measure type 17
    #> 1               <NA>                <NA>             <NA>               <NA>
    #> 2               <NA>                <NA>             <NA>               <NA>
    #> 3               <NA>                <NA>             <NA>               <NA>
    #> 4               <NA>                <NA>             <NA>               <NA>
    #> 5               <NA>                <NA>             <NA>               <NA>
    #> 6               <NA>                <NA>             <NA>               <NA>
    #> 7                                                                           
    #>   pi measure score 17 pi measure id 18 pi measure type 18 pi measure score 18
    #> 1                <NA>             <NA>               <NA>                <NA>
    #> 2                <NA>             <NA>               <NA>                <NA>
    #> 3                <NA>             <NA>               <NA>                <NA>
    #> 4                <NA>             <NA>               <NA>                <NA>
    #> 5                <NA>             <NA>               <NA>                <NA>
    #> 6                <NA>             <NA>               <NA>                <NA>
    #> 7                                                                            
    #>   pi measure id 19 pi measure type 19 pi measure score 19 pi measure id 20
    #> 1             <NA>               <NA>                <NA>             <NA>
    #> 2             <NA>               <NA>                <NA>             <NA>
    #> 3             <NA>               <NA>                <NA>             <NA>
    #> 4             <NA>               <NA>                <NA>             <NA>
    #> 5             <NA>               <NA>                <NA>             <NA>
    #> 6             <NA>               <NA>                <NA>             <NA>
    #> 7                                                                         
    #>   pi measure type 20 pi measure score 20 pi measure id 21 pi measure type 21
    #> 1               <NA>                <NA>             <NA>               <NA>
    #> 2               <NA>                <NA>             <NA>               <NA>
    #> 3               <NA>                <NA>             <NA>               <NA>
    #> 4               <NA>                <NA>             <NA>               <NA>
    #> 5               <NA>                <NA>             <NA>               <NA>
    #> 6               <NA>                <NA>             <NA>               <NA>
    #> 7                                                                           
    #>   pi measure score 21 improvement activities (ia) category weight
    #> 1                <NA>                                        <NA>
    #> 2                <NA>                                        <NA>
    #> 3                <NA>                                        <NA>
    #> 4                <NA>                                        <NA>
    #> 5                <NA>                                        <NA>
    #> 6                <NA>                                        <NA>
    #> 7                                                            0.15
    #>   cost improvement score cost category weight
    #> 1                   <NA>                 <NA>
    #> 2                   <NA>                 <NA>
    #> 3                   <NA>                 <NA>
    #> 4                   <NA>                 <NA>
    #> 5                   <NA>                 <NA>
    #> 6                   <NA>                 <NA>
    #> 7                      0                  0.3
