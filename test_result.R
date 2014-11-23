library(digest)

expectedMd5 <- "8161c06dbe59f0131a5840917d275feb" # old: "dd66b0e6216a3d831e0f0c0bb5b932ad"

data <- read.table("tidydata.txt")

md5 <- digest(data, serialize=TRUE)

stopifnot(identical(md5, expectedMd5))

print(paste('Test PASSED', md5))