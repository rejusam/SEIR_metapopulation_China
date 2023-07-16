# china_codes
Matching spatial data with human mobility data.

29/04/2022

* Corrected missing string 'Prefecture' in 2 cells for Aksu
* Generated ```location_in_flow_spatial_match_ADM2_PCODE.csv``` with ADM2_PCODE column and flag_type column
* Generated ```spatial_match.shp``` with flag_type column
* Values for ```flag_type```: 1) none, 2) 'As there is only one polygon for multiple GB_Codes you should MERGFE FLOW ', 3) 'A polygon exists but is missing flow data'

27/04/2022 after meeting: for Reju
* Reju check the flow data for that region in Tibet so we can be sure it is in Tibet: Shannanshi
* Merge these into one flow entry so we can have 1 polygon - 1 flow
* Open location_in_flow_spatial_match (attached)
*	Merge location_in_flow_spatial_match with your private flow data
*	Merge locations by using duplicated ADM2_EN column as key to aggregate them by summing their flow values
*	Maybe create a new key code column to connect all data sources easily because special characters can be annoying sometimes
*	The most important thing is to keep ADM2_EN so we can connect it to the shapefile. Let me know if you have any trouble.
*	There will be 347 unique nodes in our flow network after merging because we decided to match like this:
 
![To merge](https://github.com/renatamuy/china_codes/blob/main/to%20merge.jpg)


27/04/2022 before meeting 

* Discussed possibilities for imperfect matches with Reju and Dave
* Only in shapefile: 10 polygons

```
 setdiff(s$ADM2_EN, newsub$ADM2_EN)
 [1] "Laiwu"                                   "Taiwan province"                         "Hong Kong Special Administrative Region" "Yulin"                                  
 [5] "Fuzhou"                                  "Yichun"                                  "Luohe"                                   "Suzhou"                                 
 [9] "Taizhou"                                 "Macao Special Administrative Region"    
```
* In both, but with spatial mismatch (sub-polygon or merging flow is needed): 5 locations in flow


```
setdiff(newsub$ADM2_EN, s$ADM2_EN)
[1] "FLAG Daxinganling Prefecture"                   "FLAG Qionghai City"                             "FLAG Aksu"                                     
[4] "FLAG ÃœrÃ¼mqi"  
````




26/04/2022
* All cities looked up and most are ready for analysis.
* Final flags %in% flow: areas exclusive from flow (double check needed, sub-level polygon needed, not included in shapefile)
```
setdiff(newsub$ADM2_EN, s$ADM2_EN)

[1] "FLAG Daxinganling Prefecture" "FLAG"                         "Zhongshanshi"                 "FLAG Chengdu"                 "FLAG Nyingchi"               
[6] "FLAG Zhengzhou"               NA 
```

* Final flags %in% shapefile:  special regions, large areas with mismatch (Tibet and Inner Mongolia)
``` 
setdiff(s$ADM2_EN, newsub$ADM2_EN)
[1] "Laiwu"                                   "Taiwan province"                         "Zhongshan"                               "Hong Kong Special Administrative Region"
 [5] "Lhoka"                                   "Nyingchi"                                "Qamdo"                                   "Yulin"                                  
 [9] "Changde"                                 "Huizhou"                                 "Fuzhou"                                  "Yichun"                                 
[13] "Xi'an"                                   "Luohe"                                   "Suzhou"                                  "Taizhou"                                
[17] "Macao Special Administrative Region"     "Danzhou" 
```

22/04/2022
* Corrected 200 city codes regarding the numerical mismmatch between sources. Reason: pinying in flow , but complete names in English in UN data;
* Common pinying in flow: *shi* for city, *zuzizhizhou* for autonomous prefecture, *buyizumiao* for Buyi and Miao;
* Consistent flagging of apostroph character escape and special character scape;
* Flagging of a few detailed regions in flow not picture in UN data (mostly on Inner Mongolian areas, North, and West).
* To be done from Tuesday on: finalise code matching and book meeting with Reju.

21/04/2022
* Corrected 74 missing matches with the hardest syntax
* Main reasons for mismatch: pinying to full English, areas with more than one name. The final decision was based upon geography, dictionary and numerical code similarity);
* Raised some flags in West China (non-existent sub-polygons) open to discussion;
* To be done tomorrow: check erroneous merging codes (278 remaining lines) by syntax;
* Extract higher resolution population counts.
