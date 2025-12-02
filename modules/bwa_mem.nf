process BWA_MEM {
	tag "$sample_id"
	container "./containers/variant_image.sif"
	
	input:
		tuple val(sample_id), path(reads)
		tuple path(reference), path(index_files)
	
	output:	
		 tuple val(sample_id), path("${sample_id}.sam")
	publishDir "./results", mode: 'copy', overwrite: true

	script:
	"""
	bwa mem ${reference} ${reads} > ${sample_id}.sam
	"""

}