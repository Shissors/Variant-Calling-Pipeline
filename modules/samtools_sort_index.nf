process SAMTOOLS_SORT_INDEX {
	tag "$sample_id"
	container './containers/samtools-1.9.sif'
	
	input:
		tuple val(sample_id), path(sam_file)
	
	output:	
		tuple val(sample_id), path("${sample_id}.sorted.bam"), path("${sample_id}.sorted.bam.bai")   	
		publishDir "./results", mode: 'copy', overwrite: true

	script:
	"""
	samtools view -bS ${sam_file} | samtools sort -o ${sample_id}.sorted.bam
	samtools index ${sample_id}.sorted.bam
	"""

}