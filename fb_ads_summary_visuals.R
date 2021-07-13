

# First check that the number of unique ad ids matches the number of ads in the ad table
nrow(all_ads_table) == length(unique(all_ads_table_demo$adlib_id))
nrow(all_ads_table) == length(unique(all_ads_table_region$adlib_id))









merged_table %>% 
  group_by(page_name) %>% 
  summarise(ad_spend = sum(spend_upper), praha_percentage = mean(Prague, na.rm = TRUE)) %>% 
  arrange(desc(ad_spend))

