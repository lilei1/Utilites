#!/usr/bin/env Rscript

#   This is a script that can tranponse the matrix.
#   Written by Li Lei
#   Jan 17, 2018

#   Usage: ./transponse.R <input> <tranponsed>

#   Take command line arguments
#   Stores arguments into a vector
args <- commandArgs(trailingOnly = TRUE)

#   Function to read in data
readFile <- function(filename) {
  data.file <- read.delim(
    file = filename, # passed as an argument
    header = FALSE, # First line is a header
    sep=",", #seperate with tab
    fill = TRUE, # Fill empty fields with NAs
    na.strings = "NA"
  )
  return(data.file)
}


#   Function to write out file
writeOutFile <- function(data, outName) {
  write.table(x = data,
              file = outName,
              quote = FALSE,
              sep = "\t",
              eol = "\n",
              col.names = F,
              row.names = F)
}

#   Driver function
main <- function() {
  input <- args[1] # file name end with .hierfstat
  output <- args[2] # Output filename
  fulldata <- readFile(filename = input)
  transdata <- t(fulldata)
  writeOutFile(data = transdata, outName = output)
}

main() # Run the program
