process BCFTOOLS_CALL {

    tag "$sample_id"
    container './containers/bcftools_v1.9-1-deb_cv1.sif'

    input:
        tuple val(sample_id), path(sorted_bam)
        path reference_fasta

    output:
        tuple val(sample_id), path("${sample_id}.bcf")

    publishDir "./results", mode: 'copy', overwrite: true

    script:
    """
    bcftools mpileup -f ${reference_fasta} ${sorted_bam} -Ob -o ${sample_id}.bcf
    bcftools call -mv -Ob -o ${sample_id}.raw.bcf ${sample_id}.bcf
    """
}
