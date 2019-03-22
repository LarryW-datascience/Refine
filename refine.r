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

#Separate out product_code, product_number into separate columns
refine_data <- refine_data %>% 
  separate(Product.code...number, into = c("product_code", "product_number"))

# Export processed data as CSV
write.csv(refine_data, file = "refine_clean.csv", row.names = FALSE, quote = FALSE)