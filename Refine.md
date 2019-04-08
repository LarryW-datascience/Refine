Refine
================

Introduction
------------

In this project, I cleaned up a table listing a bunch of products along with product codes, company names, and addresses. The code below loads the libraries needed to wrangle the data (dplyr and tidyr), then imports the data into a so-called "tibble"; the data are shown below the code.

``` r
library(dplyr)
library(tidyr)
refine_data <- tbl_df(read.csv("refine_original.csv"))
```

| company    | Product.code...number | address             | city   | country         | name            |
|:-----------|:----------------------|:--------------------|:-------|:----------------|:----------------|
| Phillips   | p-5                   | Groningensingel 147 | arnhem | the netherlands | dhr p. jansen   |
| phillips   | p-43                  | Groningensingel 148 | arnhem | the netherlands | dhr p. hansen   |
| philips    | x-3                   | Groningensingel 149 | arnhem | the netherlands | dhr j. Gansen   |
| phllips    | x-34                  | Groningensingel 150 | arnhem | the netherlands | dhr p. mansen   |
| phillps    | x-12                  | Groningensingel 151 | arnhem | the netherlands | dhr p. fransen  |
| phillipS   | p-23                  | Groningensingel 152 | arnhem | the netherlands | dhr p. franssen |
| akzo       | v-43                  | Leeuwardenweg 178   | arnhem | the netherlands | dhr p. bansen   |
| Akzo       | v-12                  | Leeuwardenweg 179   | arnhem | the netherlands | dhr p. vansen   |
| AKZO       | x-5                   | Leeuwardenweg 180   | arnhem | the netherlands | dhr p. bransen  |
| akz0       | p-34                  | Leeuwardenweg 181   | arnhem | the netherlands | dhr p. janssen  |
| ak zo      | q-5                   | Leeuwardenweg 182   | arnhem | the netherlands | mevr l. rokken  |
| akzo       | q-9                   | Leeuwardenweg 183   | arnhem | the netherlands | mevr l. lokken  |
| akzo       | x-8                   | Leeuwardenweg 184   | arnhem | the netherlands | mevr l. mokken  |
| phillips   | p-56                  | Delfzijlstraat 54   | arnhem | the netherlands | mevr l. mokken  |
| fillips    | v-67                  | Delfzijlstraat 55   | arnhem | the netherlands | mevr l. mokken  |
| phlips     | v-21                  | Delfzijlstraat 56   | arnhem | the netherlands | mevr l. mokken  |
| Van Houten | x-45                  | Delfzijlstraat 57   | arnhem | the netherlands | mevr l. sokken  |
| van Houten | v-56                  | Delfzijlstraat 58   | arnhem | the netherlands | mevr l. wokken  |
| van houten | v-65                  | Delfzijlstraat 59   | arnhem | the netherlands | mevr l. kokken  |
| van houten | x-21                  | Delfzijlstraat 60   | arnhem | the netherlands | mevr l. Bokken  |
| Van Houten | p-23                  | Delfzijlstraat 61   | arnhem | the netherlands | mevr l. dokken  |
| unilver    | x-3                   | Jourestraat 23      | arnhem | the netherlands | mevr l. gokken  |
| unilever   | q-4                   | Jourestraat 24      | arnhem | the netherlands | mevr l. stokken |
| Unilever   | q-6                   | Jourestraat 25      | arnhem | the netherlands | mevr l. rokken  |
| unilever   | q-8                   | Jourestraat 26      | arnhem | the netherlands | mevr l. rokken  |

Correcting the company names
----------------------------

It's obvious that the company names are commonly misspelled. Luckily, with the exception fo "fillips", all of the first letters of the company names are correct. The code below corrects the spelling of the company names based on the first letter of each (misspelled) company name.

``` r
refine_data <- refine_data %>% 
  mutate(company = tolower(company)) %>%
  mutate(company = substr(company, 1, 1)) %>%
  mutate(company = case_when(company == "a" ~ "akzo",
                             company == "p" | company == "f" ~ "phillips",
                             company == "v" ~ "van houten",
                             company == "u" ~ "unilever"))
```

| company  | Product.code...number | address             | city   | country         | name            |
|:---------|:----------------------|:--------------------|:-------|:----------------|:----------------|
| phillips | p-5                   | Groningensingel 147 | arnhem | the netherlands | dhr p. jansen   |
| phillips | p-43                  | Groningensingel 148 | arnhem | the netherlands | dhr p. hansen   |
| phillips | x-3                   | Groningensingel 149 | arnhem | the netherlands | dhr j. Gansen   |
| phillips | x-34                  | Groningensingel 150 | arnhem | the netherlands | dhr p. mansen   |
| phillips | x-12                  | Groningensingel 151 | arnhem | the netherlands | dhr p. fransen  |
| phillips | p-23                  | Groningensingel 152 | arnhem | the netherlands | dhr p. franssen |
| akzo     | v-43                  | Leeuwardenweg 178   | arnhem | the netherlands | dhr p. bansen   |
| akzo     | v-12                  | Leeuwardenweg 179   | arnhem | the netherlands | dhr p. vansen   |
| akzo     | x-5                   | Leeuwardenweg 180   | arnhem | the netherlands | dhr p. bransen  |
| akzo     | p-34                  | Leeuwardenweg 181   | arnhem | the netherlands | dhr p. janssen  |

Separating the product number and code
--------------------------------------

It's clear that the product number and code are listed together in one column; it would be cleaner to have them in two separate columns; the code below accomplishes that.

``` r
refine_data <- refine_data %>% 
  separate(Product.code...number, into = c("product_code", "product_number"))
```

| company  | product\_code | product\_number | address             | city   | country         | name            |
|:---------|:--------------|:----------------|:--------------------|:-------|:----------------|:----------------|
| phillips | p             | 5               | Groningensingel 147 | arnhem | the netherlands | dhr p. jansen   |
| phillips | p             | 43              | Groningensingel 148 | arnhem | the netherlands | dhr p. hansen   |
| phillips | x             | 3               | Groningensingel 149 | arnhem | the netherlands | dhr j. Gansen   |
| phillips | x             | 34              | Groningensingel 150 | arnhem | the netherlands | dhr p. mansen   |
| phillips | x             | 12              | Groningensingel 151 | arnhem | the netherlands | dhr p. fransen  |
| phillips | p             | 23              | Groningensingel 152 | arnhem | the netherlands | dhr p. franssen |
| akzo     | v             | 43              | Leeuwardenweg 178   | arnhem | the netherlands | dhr p. bansen   |
| akzo     | v             | 12              | Leeuwardenweg 179   | arnhem | the netherlands | dhr p. vansen   |
| akzo     | x             | 5               | Leeuwardenweg 180   | arnhem | the netherlands | dhr p. bransen  |
| akzo     | p             | 34              | Leeuwardenweg 181   | arnhem | the netherlands | dhr p. janssen  |

Ading product categories
------------------------

The product code corresponds to the category of the product. 'p' stands for "Smartphone", 'v' stands for "TV", 'x' stands for laptop, and 'q' stands for tablet. The code below adds a column for product category.

``` r
refine_data <- refine_data %>% 
  mutate(product_category = case_when(product_code == "p" ~ "Smartphone",
                                      product_code == "v" ~ "TV",
                                      product_code == "x" ~ "Laptop",
                                      product_code == "q" ~ "Tablet"))
```

<table style="width:100%;">
<colgroup>
<col width="8%" />
<col width="11%" />
<col width="13%" />
<col width="17%" />
<col width="6%" />
<col width="14%" />
<col width="14%" />
<col width="14%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">company</th>
<th align="left">product_code</th>
<th align="left">product_number</th>
<th align="left">address</th>
<th align="left">city</th>
<th align="left">country</th>
<th align="left">name</th>
<th align="left">product_category</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">phillips</td>
<td align="left">p</td>
<td align="left">5</td>
<td align="left">Groningensingel 147</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. jansen</td>
<td align="left">Smartphone</td>
</tr>
<tr class="even">
<td align="left">phillips</td>
<td align="left">p</td>
<td align="left">43</td>
<td align="left">Groningensingel 148</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. hansen</td>
<td align="left">Smartphone</td>
</tr>
<tr class="odd">
<td align="left">phillips</td>
<td align="left">x</td>
<td align="left">3</td>
<td align="left">Groningensingel 149</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr j. Gansen</td>
<td align="left">Laptop</td>
</tr>
<tr class="even">
<td align="left">phillips</td>
<td align="left">x</td>
<td align="left">34</td>
<td align="left">Groningensingel 150</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. mansen</td>
<td align="left">Laptop</td>
</tr>
<tr class="odd">
<td align="left">phillips</td>
<td align="left">x</td>
<td align="left">12</td>
<td align="left">Groningensingel 151</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. fransen</td>
<td align="left">Laptop</td>
</tr>
<tr class="even">
<td align="left">phillips</td>
<td align="left">p</td>
<td align="left">23</td>
<td align="left">Groningensingel 152</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. franssen</td>
<td align="left">Smartphone</td>
</tr>
<tr class="odd">
<td align="left">akzo</td>
<td align="left">v</td>
<td align="left">43</td>
<td align="left">Leeuwardenweg 178</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. bansen</td>
<td align="left">TV</td>
</tr>
<tr class="even">
<td align="left">akzo</td>
<td align="left">v</td>
<td align="left">12</td>
<td align="left">Leeuwardenweg 179</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. vansen</td>
<td align="left">TV</td>
</tr>
<tr class="odd">
<td align="left">akzo</td>
<td align="left">x</td>
<td align="left">5</td>
<td align="left">Leeuwardenweg 180</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. bransen</td>
<td align="left">Laptop</td>
</tr>
<tr class="even">
<td align="left">akzo</td>
<td align="left">p</td>
<td align="left">34</td>
<td align="left">Leeuwardenweg 181</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. janssen</td>
<td align="left">Smartphone</td>
</tr>
</tbody>
</table>

Adding the full address for geocoding
-------------------------------------

For geocoding, sometimes it's useful to have the full address listed on one line. The code below creates a new collumn with the full address (address, city country)

``` r
refine_data <- refine_data %>% 
  unite("full_address", c("address", "city", "country"), sep = ", ", remove = FALSE)
```

<table>
<colgroup>
<col width="5%" />
<col width="8%" />
<col width="9%" />
<col width="27%" />
<col width="12%" />
<col width="4%" />
<col width="10%" />
<col width="10%" />
<col width="10%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">company</th>
<th align="left">product_code</th>
<th align="left">product_number</th>
<th align="left">full_address</th>
<th align="left">address</th>
<th align="left">city</th>
<th align="left">country</th>
<th align="left">name</th>
<th align="left">product_category</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">phillips</td>
<td align="left">p</td>
<td align="left">5</td>
<td align="left">Groningensingel 147, arnhem, the netherlands</td>
<td align="left">Groningensingel 147</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. jansen</td>
<td align="left">Smartphone</td>
</tr>
<tr class="even">
<td align="left">phillips</td>
<td align="left">p</td>
<td align="left">43</td>
<td align="left">Groningensingel 148, arnhem, the netherlands</td>
<td align="left">Groningensingel 148</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. hansen</td>
<td align="left">Smartphone</td>
</tr>
<tr class="odd">
<td align="left">phillips</td>
<td align="left">x</td>
<td align="left">3</td>
<td align="left">Groningensingel 149, arnhem, the netherlands</td>
<td align="left">Groningensingel 149</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr j. Gansen</td>
<td align="left">Laptop</td>
</tr>
<tr class="even">
<td align="left">phillips</td>
<td align="left">x</td>
<td align="left">34</td>
<td align="left">Groningensingel 150, arnhem, the netherlands</td>
<td align="left">Groningensingel 150</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. mansen</td>
<td align="left">Laptop</td>
</tr>
<tr class="odd">
<td align="left">phillips</td>
<td align="left">x</td>
<td align="left">12</td>
<td align="left">Groningensingel 151, arnhem, the netherlands</td>
<td align="left">Groningensingel 151</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. fransen</td>
<td align="left">Laptop</td>
</tr>
<tr class="even">
<td align="left">phillips</td>
<td align="left">p</td>
<td align="left">23</td>
<td align="left">Groningensingel 152, arnhem, the netherlands</td>
<td align="left">Groningensingel 152</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. franssen</td>
<td align="left">Smartphone</td>
</tr>
<tr class="odd">
<td align="left">akzo</td>
<td align="left">v</td>
<td align="left">43</td>
<td align="left">Leeuwardenweg 178, arnhem, the netherlands</td>
<td align="left">Leeuwardenweg 178</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. bansen</td>
<td align="left">TV</td>
</tr>
<tr class="even">
<td align="left">akzo</td>
<td align="left">v</td>
<td align="left">12</td>
<td align="left">Leeuwardenweg 179, arnhem, the netherlands</td>
<td align="left">Leeuwardenweg 179</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. vansen</td>
<td align="left">TV</td>
</tr>
<tr class="odd">
<td align="left">akzo</td>
<td align="left">x</td>
<td align="left">5</td>
<td align="left">Leeuwardenweg 180, arnhem, the netherlands</td>
<td align="left">Leeuwardenweg 180</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. bransen</td>
<td align="left">Laptop</td>
</tr>
<tr class="even">
<td align="left">akzo</td>
<td align="left">p</td>
<td align="left">34</td>
<td align="left">Leeuwardenweg 181, arnhem, the netherlands</td>
<td align="left">Leeuwardenweg 181</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. janssen</td>
<td align="left">Smartphone</td>
</tr>
</tbody>
</table>

Creating dummy variables for company and product category
---------------------------------------------------------

Both the company name and product category are categorical variables, **i.e.** they each have a fixed set of values (four in each case.) The code below adds "dummy variables" which show whether each product is from each company, and whether each product is part of each product category.

``` r
refine_data <- refine_data %>% 
  mutate(company_phillips = case_when(company == "phillips" ~ 1,
                                      TRUE ~ 0),
         company_akzo = case_when(company == "akzo" ~1,
                                  TRUE ~ 0 ),
         company_van_houten = case_when(company =="van houten" ~ 1,
                                        TRUE ~ 0),
         company_unilever = case_when(company == "unilever" ~ 1,
                                      TRUE ~ 0),
         product_smartphone = case_when(product_category == "Smartphone" ~ 1,
                                        TRUE ~ 0),
         product_tv = case_when (product_category == "TV" ~ 1,
                                 TRUE ~ 0),
         product_laptop = case_when (product_category == "Laptop" ~ 1,
                                     TRUE ~ 0),
         product_tablet = case_when (product_category == "Tablet" ~ 1,
                                     TRUE ~ 0))
```

At this point, the data is fully "wrangled" for the purposes of this project; the data can be written to a new CSV file as shown below:

``` r
write.csv(refine_data, file = "refine_clean.csv", row.names = FALSE, quote = FALSE)
```

And for the sake of completeness, the fully "wrangled" data is shown below:

<table>
<colgroup>
<col width="3%" />
<col width="4%" />
<col width="5%" />
<col width="15%" />
<col width="6%" />
<col width="2%" />
<col width="5%" />
<col width="5%" />
<col width="5%" />
<col width="5%" />
<col width="4%" />
<col width="6%" />
<col width="5%" />
<col width="6%" />
<col width="3%" />
<col width="5%" />
<col width="5%" />
</colgroup>
<thead>
<tr class="header">
<th align="left">company</th>
<th align="left">product_code</th>
<th align="left">product_number</th>
<th align="left">full_address</th>
<th align="left">address</th>
<th align="left">city</th>
<th align="left">country</th>
<th align="left">name</th>
<th align="left">product_category</th>
<th align="right">company_phillips</th>
<th align="right">company_akzo</th>
<th align="right">company_van_houten</th>
<th align="right">company_unilever</th>
<th align="right">product_smartphone</th>
<th align="right">product_tv</th>
<th align="right">product_laptop</th>
<th align="right">product_tablet</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="left">phillips</td>
<td align="left">p</td>
<td align="left">5</td>
<td align="left">Groningensingel 147, arnhem, the netherlands</td>
<td align="left">Groningensingel 147</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. jansen</td>
<td align="left">Smartphone</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="even">
<td align="left">phillips</td>
<td align="left">p</td>
<td align="left">43</td>
<td align="left">Groningensingel 148, arnhem, the netherlands</td>
<td align="left">Groningensingel 148</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. hansen</td>
<td align="left">Smartphone</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="odd">
<td align="left">phillips</td>
<td align="left">x</td>
<td align="left">3</td>
<td align="left">Groningensingel 149, arnhem, the netherlands</td>
<td align="left">Groningensingel 149</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr j. Gansen</td>
<td align="left">Laptop</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
</tr>
<tr class="even">
<td align="left">phillips</td>
<td align="left">x</td>
<td align="left">34</td>
<td align="left">Groningensingel 150, arnhem, the netherlands</td>
<td align="left">Groningensingel 150</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. mansen</td>
<td align="left">Laptop</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
</tr>
<tr class="odd">
<td align="left">phillips</td>
<td align="left">x</td>
<td align="left">12</td>
<td align="left">Groningensingel 151, arnhem, the netherlands</td>
<td align="left">Groningensingel 151</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. fransen</td>
<td align="left">Laptop</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
</tr>
<tr class="even">
<td align="left">phillips</td>
<td align="left">p</td>
<td align="left">23</td>
<td align="left">Groningensingel 152, arnhem, the netherlands</td>
<td align="left">Groningensingel 152</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. franssen</td>
<td align="left">Smartphone</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="odd">
<td align="left">akzo</td>
<td align="left">v</td>
<td align="left">43</td>
<td align="left">Leeuwardenweg 178, arnhem, the netherlands</td>
<td align="left">Leeuwardenweg 178</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. bansen</td>
<td align="left">TV</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="even">
<td align="left">akzo</td>
<td align="left">v</td>
<td align="left">12</td>
<td align="left">Leeuwardenweg 179, arnhem, the netherlands</td>
<td align="left">Leeuwardenweg 179</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. vansen</td>
<td align="left">TV</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="odd">
<td align="left">akzo</td>
<td align="left">x</td>
<td align="left">5</td>
<td align="left">Leeuwardenweg 180, arnhem, the netherlands</td>
<td align="left">Leeuwardenweg 180</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. bransen</td>
<td align="left">Laptop</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
</tr>
<tr class="even">
<td align="left">akzo</td>
<td align="left">p</td>
<td align="left">34</td>
<td align="left">Leeuwardenweg 181, arnhem, the netherlands</td>
<td align="left">Leeuwardenweg 181</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">dhr p. janssen</td>
<td align="left">Smartphone</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="odd">
<td align="left">akzo</td>
<td align="left">q</td>
<td align="left">5</td>
<td align="left">Leeuwardenweg 182, arnhem, the netherlands</td>
<td align="left">Leeuwardenweg 182</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. rokken</td>
<td align="left">Tablet</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">akzo</td>
<td align="left">q</td>
<td align="left">9</td>
<td align="left">Leeuwardenweg 183, arnhem, the netherlands</td>
<td align="left">Leeuwardenweg 183</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. lokken</td>
<td align="left">Tablet</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
</tr>
<tr class="odd">
<td align="left">akzo</td>
<td align="left">x</td>
<td align="left">8</td>
<td align="left">Leeuwardenweg 184, arnhem, the netherlands</td>
<td align="left">Leeuwardenweg 184</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. mokken</td>
<td align="left">Laptop</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
</tr>
<tr class="even">
<td align="left">phillips</td>
<td align="left">p</td>
<td align="left">56</td>
<td align="left">Delfzijlstraat 54, arnhem, the netherlands</td>
<td align="left">Delfzijlstraat 54</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. mokken</td>
<td align="left">Smartphone</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="odd">
<td align="left">phillips</td>
<td align="left">v</td>
<td align="left">67</td>
<td align="left">Delfzijlstraat 55, arnhem, the netherlands</td>
<td align="left">Delfzijlstraat 55</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. mokken</td>
<td align="left">TV</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="even">
<td align="left">phillips</td>
<td align="left">v</td>
<td align="left">21</td>
<td align="left">Delfzijlstraat 56, arnhem, the netherlands</td>
<td align="left">Delfzijlstraat 56</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. mokken</td>
<td align="left">TV</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="odd">
<td align="left">van houten</td>
<td align="left">x</td>
<td align="left">45</td>
<td align="left">Delfzijlstraat 57, arnhem, the netherlands</td>
<td align="left">Delfzijlstraat 57</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. sokken</td>
<td align="left">Laptop</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
</tr>
<tr class="even">
<td align="left">van houten</td>
<td align="left">v</td>
<td align="left">56</td>
<td align="left">Delfzijlstraat 58, arnhem, the netherlands</td>
<td align="left">Delfzijlstraat 58</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. wokken</td>
<td align="left">TV</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="odd">
<td align="left">van houten</td>
<td align="left">v</td>
<td align="left">65</td>
<td align="left">Delfzijlstraat 59, arnhem, the netherlands</td>
<td align="left">Delfzijlstraat 59</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. kokken</td>
<td align="left">TV</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="even">
<td align="left">van houten</td>
<td align="left">x</td>
<td align="left">21</td>
<td align="left">Delfzijlstraat 60, arnhem, the netherlands</td>
<td align="left">Delfzijlstraat 60</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. Bokken</td>
<td align="left">Laptop</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
</tr>
<tr class="odd">
<td align="left">van houten</td>
<td align="left">p</td>
<td align="left">23</td>
<td align="left">Delfzijlstraat 61, arnhem, the netherlands</td>
<td align="left">Delfzijlstraat 61</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. dokken</td>
<td align="left">Smartphone</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
</tr>
<tr class="even">
<td align="left">unilever</td>
<td align="left">x</td>
<td align="left">3</td>
<td align="left">Jourestraat 23, arnhem, the netherlands</td>
<td align="left">Jourestraat 23</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. gokken</td>
<td align="left">Laptop</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
</tr>
<tr class="odd">
<td align="left">unilever</td>
<td align="left">q</td>
<td align="left">4</td>
<td align="left">Jourestraat 24, arnhem, the netherlands</td>
<td align="left">Jourestraat 24</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. stokken</td>
<td align="left">Tablet</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
</tr>
<tr class="even">
<td align="left">unilever</td>
<td align="left">q</td>
<td align="left">6</td>
<td align="left">Jourestraat 25, arnhem, the netherlands</td>
<td align="left">Jourestraat 25</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. rokken</td>
<td align="left">Tablet</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
</tr>
<tr class="odd">
<td align="left">unilever</td>
<td align="left">q</td>
<td align="left">8</td>
<td align="left">Jourestraat 26, arnhem, the netherlands</td>
<td align="left">Jourestraat 26</td>
<td align="left">arnhem</td>
<td align="left">the netherlands</td>
<td align="left">mevr l. rokken</td>
<td align="left">Tablet</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">0</td>
<td align="right">1</td>
</tr>
</tbody>
</table>
