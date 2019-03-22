library(dplyr)

# Import CSV file
refine_data <- tbl_df(read.csv("refine_original.csv"))

# Correct company name

# First get each company name as individual first letter,
# Then correct spelling based on first letter
refine_data <- refine_data %>% 
  mutate(company = tolower(company)) %>%
  mutate(company = substr(company, 1, 1)) %>%
  mutate(company = case_when(company == "a" ~ "akzo",
                             company == "p" | company == "f" ~ "phillips",
                             company == "v" ~ "van houten",
                             company == "u" ~ "unilever"))

# Separate out product_code, product_number into separate columns
refine_data <- refine_data %>% 
  separate(Product.code...number, into = c("product_code", "product_number"))

# Add product categories
refine_data <- refine_data %>% 
  mutate(product_category = case_when(product_code == "p" ~ "Smartphone",
                                      product_code == "v" ~ "TV",
                                      product_code == "x" ~ "Laptop",
                                      product_code == "q" ~ "Tablet"))

# Combine address blocks into an address
refine_data <- refine_data %>% 
  unite("full_address", c("address", "city", "country"), sep = ", ", remove = FALSE)

# Create dummy categories for company and product category
refine_data <- refine_data %>% 
  mutate(company_phillips = case_when(company == "phillips" ~ 1,
                                      TRUE ~ 0),
         company_akzo = case_when(company == "akzo" ~1,
                                  TRUE ~ 0 ),
         company_van_houten = case_when(company =="van houten" ~ 1,
                                        TRUE ~ 0),
         company_unilever = case_when(company == "unilever" ~ 1,
                                      TRUE ~ 0))

# Export processed data as CSV
write.csv(refine_data, file = "refine_clean.csv", row.names = FALSE, quote = FALSE)