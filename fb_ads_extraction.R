# We have to install the Radlibrary package, which is available only on GitHub
library(dplyr)
library(readr)
library(tidyr)
library(devtools)
devtools::install_github("facebookresearch/Radlibrary")
library(Radlibrary)

get_all_tables_merge <- function(token, parties_ids, max_date) {
 
  # EXTRACTION PART OF THE FUNCTION
  fields_vector <- c("ad_data", "region_data", "demographic_data")
  table_type_vector <- c("ad", "region", "demographic")
  
  # First, we need a for loop to get us the 3 distinct types of tables from the FB Ads.
  
  for (i in 1:length(fields_vector)) {
  
   # Building the query
  query <- adlib_build_query(ad_reached_countries = "CZ", 
                                 ad_active_status = "ALL", 
                                 ad_delivery_date_max = max_date,
                                 ad_delivery_date_min = "2021-01-01",
                                 ad_type = "POLITICAL_AND_ISSUE_ADS",
                                 limit = 1000, 
                                 search_page_ids = parties_ids,
                                 fields = fields_vector[i])  
  
  # The call is limited to last 1000 results, pagination overcomes it
  response <- adlib_get_paginated(query, token, max_gets = 10) 
  assign(paste0("dataset_", table_type_vector[i]), as_tibble(response, type = table_type_vector[i], censor_access_token = TRUE))
  
  print(i)
  # We save each of these tables to a csv file
  
  myfile <- paste0("data/", fields_vector[i], ".csv")
  mydataset <- get(paste0("dataset_", table_type_vector[i]))
  write_excel_csv(x = mydataset, file = myfile)
  
  }
  # MERGE PART OF THE FUNCTION
  # After extraction of the three tables through the for loop, we transform and merge into one
  
  # The demographic and region datasets are in the "long" format
  # We need to transform them to a "wide" format which mathes the ad dataset
  dataset_demographic_wide <- pivot_wider(dataset_demographic, 
                                          id_cols = adlib_id, 
                                          names_from = c("gender", "age"), 
                                          names_sort = TRUE,
                                          values_from = percentage)
  
  dataset_region_wide <- pivot_wider(dataset_region, 
                                     id_cols = adlib_id, 
                                     names_from = region, 
                                     names_sort = TRUE,
                                     values_from = percentage)  
 
  merged_dataset <- dataset_ad %>% 
                    left_join(dataset_demographic_wide, by = "adlib_id") %>% 
                    left_join(dataset_region_wide, by = "adlib_id") %>% 
                    mutate(across(c("funding_entity", 
                                    "currency",
                                    "page_name"), factor))
  
  write_excel_csv(merged_dataset, file = "data/merged_data.csv") 
  
}

# Specifying the arguments needed to run the function

token_fb_ads <- Sys.getenv("FB_TOKEN")
# Get today's and yesterday's date in format FB wants for automation
today <- format((Sys.Date()), "%Y-%m-%d")
yesterday <- format((Sys.Date() - 1), "%Y-%m-%d")
parties <- c("179497582061065",
             "1477535869227488",
             "90002267161",
             "109323929038",
             "214827221987263",
             "30575632699")

# Current token expires on October 7 2021. It need to be prolonged before then.

# FB Pages API requires that we either give it a search term, or, give it the FB Page ids
# We can specify up to 10 FB Page ids, they have to be numeric. This is not easy to find.
# We can find numeric ids from the already queried table.

# Current parties in the query
# Tomio Okamura - SPD: "179497582061065"
# Vit Rakusan: "1477535869227488"
# TOP09: "90002267161"
# Ceska Piratska Strana: "109323929038"
# Andrej Babis: "214827221987263"
# ODS - Občanská demokratická strana: "30575632699"


# Running the function by providing it with appropriate arguments
# The end result should be 4 tables saved in the data folder
get_all_tables_merge(token = token_fb_ads, parties_ids = parties, max_date = today)
