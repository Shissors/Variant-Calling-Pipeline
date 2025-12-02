process BCFTOOLS_QUERY {
    tag "$sample_id"
    container './containers/bcftools_v1.9-1-deb_cv1.sif'

    input:
        tuple val(sample_id), path(vcf_file)

    output:
        tuple val(sample_id), path("${sample_id}_plots/variants.tsv")

    script:
    """
    mkdir -p ${sample_id}_plots
    bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%QUAL\t%DP\n' ${vcf_file} > ${sample_id}_plots/variants.tsv
    """
}