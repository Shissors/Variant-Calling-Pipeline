process FASTQC {
	tag "$sample_id"
	container "./containers/variant_image.sif"
	
	input:
	tuple val(sample_id), path(reads)

	output:
	file "${sample_id}_fastqc/*.html"
    	file "${sample_id}_fastqc/*.zip"

	publishDir "./results", mode: 'copy', overwrite: true


	script:
	"""
	mkdir -p ${sample_id}_fastqc

	fastqc ${reads} --outdir ${sample_id}_fastqc 
	"""

}