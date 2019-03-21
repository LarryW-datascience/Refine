library(dplyr)

# Import CSV file
refine_data <- tbl_df(read.csv("refine_original.csv"))

# Export processed data as CSV
write.csv(refine_data, file = "refine_clean.csv", row.names = FALSE, quote = FALSE)
