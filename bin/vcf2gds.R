#!/usr/bin/env Rscript


#################################################################
# Usage: 
# 
# vcf2gds.R --vcf_file input.vcf.gz
# 
# Options: 
# 
# vcf_file      (mandatory) Input vcf.gz file
# out_gds_file  (optional) Output file name
# threads       (optional) Number of CPU threads
# verbose       (optional) Verbose mode (default - TRUE)
#
#################################################################

## Collect arguments
args <- commandArgs(TRUE)

## Parse arguments (we expect the form --arg=value)
parseArgs    <- function(x) strsplit(sub("^--", "", x), "=")
argsL        <- as.list(as.character(as.data.frame(do.call("rbind", parseArgs(args)))$V2))
names(argsL) <- as.data.frame(do.call("rbind", parseArgs(args)))$V1
args         <- argsL
rm(argsL)

## Give some value to optional arguments if not provided
if(is.null(args$vcf_file)) {stop(paste("Provide --vcf_file"))} else {vcf_file=as.character(args$vcf_file)}
if(is.null(args$out_gds_file)) {out_gds_file=sub(".vcf.gz",".gds",basename(vcf_file))} else {out_gds_file=as.character(args$out_gds_file)}
if(is.null(args$threads)) {threads = 1} else {threads=as.numeric(args$threads)}
if(is.null(args$verbose)) {verbose = TRUE} else {verbose=args$verbose}

library(SeqArray)
library(parallel)

seqParallelSetup(threads)

seqVCF2GDS(vcf_file, out_gds_file, verbose=verbose, parallel= TRUE, storage.option="ZIP_RA")

seqParallelSetup(FALSE)