## This document intends to explain the meaning and logic behind some of the variables that are included in the summary tables.

### The summary tables input the raw ads information contained in the data folder (one row equals one advertisement) and aggregates them on the level of each advertiser (one row equals one actor).

### Only entites that had at least one political ad since 1 January 2021 are included within the summary tables. Also, only Czech regions are included in the region summary & merged tables. In the demographic & merged tables, we did not include the columns of "unknown gender", because vast majority of the values were equal to 0 or less than 0.1 %. 

### Description of selected variables:
- Unique ads & percent unique ads: Non-uniqueness means that the text ("ad_creative_body" from the raw dataset) of a particular ad (identified by the "adlib_id") is exactly the same as some other ad with a different "adlib_id". This means, that a difference of even one character means that the ad would be identified as unique.
- 
