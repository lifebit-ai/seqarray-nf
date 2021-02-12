# seqarray-nf

A nextflow pipeline for using [SeqArray](https://bioconductor.org/packages/release/bioc/html/SeqArray.html) GDS files format APIs for VCF files.

## Test run

```bash
cd seqarray-nf
nextflow run main.nf --vcf_files test_vcfs.txt -profile docker,base
```
