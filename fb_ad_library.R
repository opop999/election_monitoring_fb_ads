# We have to install the Radlibrary package, which is available only on GH

library(devtools)
library(tidyverse)

devtools::install_github("facebookresearch/Radlibrary")

library(Radlibrary)

token <- Sys.getenv("FB_TOKEN")

# Parameters of the query

# FB Pages API requires that we either give it a search term, or, give it the FB Page ids
# We can specify up to 10 FB Page ids, they have to be numeric. This is not easy to find.
# We can find numeric ids from the already queried table.

# Tomio Okamura - SPD: "179497582061065"
# Vit Rakusan: "1477535869227488"
# TOP09: "90002267161"
# Ceska Piratska Strana: "109323929038"
# Andrej Babis: "214827221987263"
# ODS - Občanská demokratická strana: "30575632699"

# Building the query

query_ads <- adlib_build_query(ad_reached_countries = "CZ", 
                           ad_active_status = "ALL", 
                           ad_delivery_date_max = "2021-07-09",
                           ad_delivery_date_min = "2021-01-01",
                           ad_type = "POLITICAL_AND_ISSUE_ADS",
                           limit = 1000, 
                           search_page_ids = c("179497582061065",
                                               "1477535869227488",
                                               "90002267161",
                                               "109323929038",
                                               "214827221987263",
                                               "30575632699"),
                           fields = "ad_data")


response <- adlib_get_paginated(query_ads, token, max_gets = 10) # The call is limited to 1000 results, pagination overcomes it

all_ads_table <- as_tibble(response, type = "ad", censor_access_token = TRUE)


# Region data of selected ads


query_region <- adlib_build_query(ad_reached_countries = "CZ", 
                               ad_active_status = "ALL", 
                               ad_delivery_date_max = "2021-07-09",
                               ad_delivery_date_min = "2021-01-01",
                               ad_type = "POLITICAL_AND_ISSUE_ADS",
                               limit = 1000, 
                               search_page_ids = c("179497582061065",
                                                   "1477535869227488",
                                                   "90002267161",
                                                   "109323929038",
                                                   "214827221987263",
                                                   "30575632699"),
                               fields = "region_data")

response <- adlib_get_paginated(query_region, token, max_gets = 10)

all_ads_table_region <- as_tibble(response, 
                                 type = "region")

# Demographic  data of selected ads


query_demo <- adlib_build_query(ad_reached_countries = "CZ", 
                                  ad_active_status = "ALL", 
                                  ad_delivery_date_max = "2021-07-09",
                                  ad_delivery_date_min = "2021-01-01",
                                  ad_type = "POLITICAL_AND_ISSUE_ADS",
                                  limit = 1000, 
                                  search_page_ids = c("179497582061065",
                                                      "1477535869227488",
                                                      "90002267161",
                                                      "109323929038",
                                                      "214827221987263",
                                                      "30575632699"),
                                  fields = "demographic_data")

response <- adlib_get_paginated(query_demo, token, max_gets = 10)

all_ads_table_demo <- as_tibble(response, 
                                  type = "demographic")


# Merging tables into one, required transformation
# First check that the number of unique ad ids matches the number of ads in the ad table
nrow(all_ads_table) == length(unique(all_ads_table_demo$adlib_id))
nrow(all_ads_table) == length(unique(all_ads_table_region$adlib_id))

all_ads_table_demo_wide <- pivot_wider(all_ads_table_demo, 
                                       id_cols = adlib_id, 
                                       names_from = c("gender", "age"), 
                                       names_sort = TRUE,
                                       values_from = percentage)

all_ads_table_region_wide <- pivot_wider(all_ads_table_region, 
                                       id_cols = adlib_id, 
                                       names_from = region, 
                                       names_sort = TRUE,
                                       values_from = percentage)

merged_table <- all_ads_table %>% 
                left_join(all_ads_table_demo_wide, by = "adlib_id") %>% 
                left_join(all_ads_table_region_wide, by = "adlib_id") %>% 
                mutate(across(c("funding_entity", 
                                "currency",
                                "page_name"), factor)) %>% 
                select(-ad_snapshot_url)

merged_table %>% 
  group_by(page_name) %>% 
  summarise(ad_spend = sum(spend_upper), praha_percentage = mean(Prague, na.rm = TRUE)) %>% 
  arrange(desc(ad_spend))


write_excel_csv(merged_table, file = "data/fb_ads/all_ads_table.csv") # Writing everything but the last column, which can contain sensitive API key


# Get today's and yesterday's date in format FB wants for automation
format((Sys.Date()), "%Y-%m-%d")
format((Sys.Date() - 1), "%Y-%m-%d")

# Need to generate a longer-term bearer token!!!
