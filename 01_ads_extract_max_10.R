# THIS VERSION OF THE SCRIPT IS CAPABLE OF EXTRACTING A MAXIMUM OF 10 FB PAGES,
# WHOSE IDs WE HAVE TO SPECIFY IN A "PARTIES" VECTOR

# PART 1: LOAD THE REQUIRED LIBRARIES FOR THIS SCRIPT

# Package names
packages <- c("dplyr", "readr", "tidyr", "remotes")

# Install packages not yet installed
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages], repos = 'http://cran.rstudio.com', dependencies = TRUE)
}

# Packages loading
invisible(lapply(packages, library, character.only = TRUE))

# We have to install the Radlibrary package, which is available only on GitHub
# To install Radlibrary, we need to use install_github function from a lightweight
# remotes package. We also specify argument "upgrade" to never, so we do not get
# a dialog window asking us whether to update when the script runs automatically.
remotes::install_github("facebookresearch/Radlibrary", upgrade = "never", dependencies = TRUE)
library(Radlibrary)

# Disable scientific notation of numbers
options(scipen = 999)

# PART 2: DEFINE THE FUNCTION THAT WILL EXTRACT, MERGE AND SAVE FB ADS DATASETS

get_all_tables_merge <- function(token, parties_ids, max_date, directory) {

  # A. SPECIFICATION PART OF THE FUNCTION
  # We need to specify the arguments we want to supply the Radlibrary functions
  fields_vector <- c("ad_data", "region_data", "demographic_data")
  table_type_vector <- c("ad", "region", "demographic")

  # We have to create a desired directory, if one does not yet exist
  if (!dir.exists(directory)) {
    dir.create(directory)
  } else {
    print("output directory already exists")
  }

  # B. EXTRACTION PART OF THE FUNCTION

  # we need a for loop to get us the 3 distinct types of tables from the FB Ads.

  for (i in seq_len(length(fields_vector))) {

    # Building the query
    query <- adlib_build_query(
      ad_reached_countries = "CZ",
      ad_active_status = "ALL",
      ad_delivery_date_max = max_date,
      ad_delivery_date_min = "2021-01-01",
      ad_type = "POLITICAL_AND_ISSUE_ADS",
      publisher_platform = c("FACEBOOK", "INSTAGRAM"),
      limit = 1000,
      search_page_ids = parties_ids,
      fields = fields_vector[i]
    )

    # The call is limited to last 1000 results, pagination overcomes it
    response <- adlib_get_paginated(query, token, max_gets = 10)

    assign(
      paste0(
        "dataset_",
        table_type_vector[i]
      ),
      as_tibble(response,
        type = table_type_vector[i],
        censor_access_token = TRUE
      )
    )

    print(i)

    # We save each of these tables to a csv and rds file
    myfile_csv <- paste0(directory, "/", fields_vector[i], ".csv")
    mydataset <- get(paste0("dataset_", table_type_vector[i]))

    write_excel_csv(x = mydataset, file = myfile_csv)
  }

  # C. MERGE PART OF THE FUNCTION
  # After extraction of the three tables through the for loop, we transform and merge into one
  # The demographic and region datasets are in the "long" format
  # We need to transform them to a "wide" format which matches the ad dataset

  dataset_demographic_wide <- dataset_demographic %>%
    mutate(across(percentage, round, 3)) %>%
    pivot_wider(
      id_cols = adlib_id,
      names_from = c("gender", "age"),
      names_sort = TRUE,
      values_from = percentage
    )

  dataset_region_wide <- dataset_region %>%
    mutate(across(percentage, round, 3)) %>%
    pivot_wider(
      id_cols = adlib_id,
      names_from = region,
      names_sort = TRUE,
      values_from = percentage
    )

  # Performing the join on common columns across the 3 datasets
  merged_dataset <- dataset_ad %>%
    left_join(dataset_demographic_wide, by = "adlib_id") %>%
    left_join(dataset_region_wide, by = "adlib_id") %>%
    mutate(across(c(
      "funding_entity",
      "currency",
      "page_name",
      "page_id"
    ), factor)) %>%
    filter(ad_creation_time >= as.Date("2021-01-01")) %>%
    arrange(desc(ad_creation_time))

  # Finally, we save the merged dataset as well, both in the csv and rds formats
  # Rds will enable faster reading when using the dataset for further analyses
  myfile_merged_csv <- paste0(directory, "/merged_data.csv")
  myfile_merged_rds <- paste0(directory, "/merged_data.rds")
  saveRDS(object = merged_dataset, file = myfile_merged_rds, compress = FALSE)
  write_excel_csv(x = merged_dataset, file = myfile_merged_csv)
}

# PART 3: SPECIFY THE ARGUMENTS NEEDED TO RUN THE FUNCTION

# Current token expires on October 7 2021. It need to be prolonged before then.
token_fb_ads <- Sys.getenv("FB_TOKEN")

# Get today's date in format FB wants for automation
today <- format((Sys.Date()), "%Y-%m-%d")

# FB Pages API requires that we either give it a search term, or, give it the FB Page ids
# We can specify up to 10 FB Page ids in this vector, they have to be numeric.
# The numeric ids are not easy to find for many pages and FB does not provide an easy way.
# However, we can find numeric ids from the already queried table if we search
# using the search_terms argument of the adlib_build_query function from Radlibrary.
parties <- c(
  "179497582061065",
  "1477535869227488",
  "90002267161",
  "109323929038",
  "214827221987263",
  "30575632699"
)

# Specify the desired output folder
dir_name <- "data"

# PART 4: RUNNING THE FUNCTION WITH APPROPRIATE ARGUMENTS

# The end result should be 4 tables saved in the data folder
get_all_tables_merge(
  token = token_fb_ads,
  parties_ids = parties,
  max_date = today,
  directory = dir_name
)
