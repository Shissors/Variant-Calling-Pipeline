nextflow.enable.dsl = 2

include { FASTQC } from "./modules/fastqc.nf"
include { BWA_INDEX } from "./modules/bwa_index.nf"
include { BWA_MEM } from "./modules/bwa_mem.nf"
include { SAMTOOLS_SORT_INDEX } from "./modules/samtools_sort_index.nf"
include { BCFTOOLS_CALL } from "./modules/bcftools_call.nf"
include { BCFTOOLS_VIEW } from "./modules/bcftools_view.nf"
include { BCFTOOLS_QUERY } from "./modules/bcftools_query.nf"
include { VARIANT_PLOT } from "./modules/variant_plot.nf"


workflow {

    reads_ch = Channel.fromPath(params.reads)

    samples_ch = reads_ch.map { f ->
        def sample_id = f.baseName.replaceAll(/\.fastq(\.gz)?$/, '')
        tuple(sample_id, f)
    }

    FASTQC(samples_ch)

    ref_ch = Channel.fromPath(params.reference)

    indexed_ref = BWA_INDEX(ref_ch)

    aligned = BWA_MEM(samples_ch, indexed_ref)

    sorted_bam = SAMTOOLS_SORT_INDEX(aligned)

    ref_file = file(params.reference)
	clean_bam = sorted_bam.map { sample_id, bam, bai -> tuple(sample_id, bam) }

    raw_bcf= BCFTOOLS_CALL(clean_bam, ref_file)
    final_vcf_ch= BCFTOOLS_VIEW(raw_bcf)
    tsv_ch=BCFTOOLS_QUERY(final_vcf_ch)
    VARIANT_PLOT(tsv_ch)
    
}
