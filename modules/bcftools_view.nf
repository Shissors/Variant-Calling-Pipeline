process BCFTOOLS_VIEW {

    tag "$sample_id"
    container './containers/bcftools_v1.9-1-deb_cv1.sif'

    input:
        tuple val(sample_id), path(raw_bcf)
        

    output:
        tuple val(sample_id), path("${sample_id}.calls.vcf.gz")

    publishDir "./results", mode: 'copy', overwrite: true

    script:
    """
    bcftools call -mv --ploidy GRCh38 -Oz -o ${sample_id}.calls.vcf.gz ${raw_bcf}
    bcftools index ${sample_id}.calls.vcf.gz
    """
}
