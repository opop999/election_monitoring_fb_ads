merged_table %>% 
  group_by(page_name) %>% 
  summarise(ad_spend = sum(spend_upper), praha_percentage = mean(Prague, na.rm = TRUE)) %>% 
  arrange(desc(ad_spend))

