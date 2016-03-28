## Install packages needed to wrangle data.

install.packages("dplyr")
install.packages("tidyr")

library(tidyr)
library(dplyr)

## make sure doc is in right file path
list.files()

## Load file into local data frame
refined <- read.csv("~/refine_original.csv")


## Clean up brand names
refined$company[1:6] <-"philips"
refined$company[7:13] <- "akzo"
refined$company[14:16] <- "philips"
refined$company[17:21] <- "van houten"
refined$company[22:25] <- "unilever"

##Seperate product code and number
refined <- refined %>%
  separate(Product.code...number, c("product_code","product_number"))

## Add product categories

pcat <- refined$product_code


i <- 1

while( i != 26){
  ifelse(grepl("[p]",pcat[i]),
         pcat[i] <-"Smartphone",
  ifelse(grepl("[x]", pcat[i]),
         pcat[i] <-"Laptop",
  ifelse(grepl("[v]", pcat[i]),
         pcat[i] <-"TV",
  ifelse(grepl("[q]", pcat[i]),
         pcat[i] <-"Tablet", NULL)       )       )       )
  i <- i+1
}
## verify pcat is now a vector with product categories
pcat

refined <- refined %>%
  mutate(product_category = pcat) %>%
  select(company, product_code, product_number, product_category, address, city, country, name)


##Add full address for geocoding
refined <- refined %>%
  unite(address, 5,6, sep = ", ") %>%
  unite(address, 7,5,6, sep = "   ")

## Create dummy variables for company and product category

comp <- refined$company
coma <- rep(0, times = 25)
comv <- coma
comu <- coma
comh <- coma

i <- 1

while( i != 26){
  ifelse(grepl("^[p]+",comp[i]),
         comh[i] <- 1,
  ifelse(grepl("^[a]+", comp[i]),
        coma[i] <-1,
  ifelse(grepl("^[v]+", comp[i]),
        comv[i] <-1,
  ifelse(grepl("^[u]+", comp[i]),
        comu[i] <-1, comh[i] <-0)       )       )       )
  i <- i+1
}

refined <- refined %>%
  mutate(company_philips = comh) %>%
  mutate(company_akzo = coma) %>%
  mutate(company_van_houten = comv) %>%
  mutate(company_unilever = comu)


##product category

comp <- refined$product_code
coma <- rep(0, times = 25) ##laptop (saw no need to change formula...)
comv <- coma  ## TV
comu <- coma  ## tablet
comh <- coma  ##smartphone


i <- 1

while( i != 26){
  ifelse(grepl("[p]",comp[i]),
         comh[i] <-1,
  ifelse(grepl("[x]", comp[i]),
        coma[i] <-1,
  ifelse(grepl("[v]", comp[i]),
        comv[i] <-1,
  ifelse(grepl("[q]", comp[i]),
        comu[i] <-1, comh[i] <-0)       )       )       )
  i <- i+1
}


refined <-refined %>%
  mutate(product_smartphone = comh) %>%
  mutate(product_laptop = coma) %>%
  mutate(product_tv = comv) %>%
  mutate(product_tablet = comu)

## Export the data
write.csv(refined, file = "refine_clean.csv")