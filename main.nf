#!/usr/bin/env nextflow

Channel
    .fromPath(params.input)
    .ifEmpty { exit 1, "Cannot find VCF files : ${params.input}" }
    .splitCsv()
    .map { vcf_file -> file(vcf_file[0]) }
    .set { ch_input }

process SeqArray {
    tag "$vcf_file"
    label 'high_memory'
    publishDir "${params.outdir}/SeqArray/", mode: 'copy'

    input:
    file(vcf_file) from ch_input

    output:
    file "${vcf_file_name}.gds" into ch_gds_file
    file "${vcf_file_name}_vcf2gds.log"

    script:
    vcf_file_name=vcf_file.getSimpleName()
    """
    vcf2gds.R --vcf_file=$vcf_file \
        --threads=${task.cpus} \
        --out_gds_file=${vcf_file_name}.gds \
        > ${vcf_file_name}_vcf2gds.log
    """
}
