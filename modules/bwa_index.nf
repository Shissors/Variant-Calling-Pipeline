process BWA_INDEX {
	tag "$reference"
	container "./containers/variant_image.sif"
	
	input:
		path reference
	
	output:	
		tuple path(reference), path("${reference}.*")
	publishDir "./results/index", mode: 'copy', overwrite: true

	script:
	"""
	echo "Indexing reference: ${reference}"
	bwa index ${reference}
	"""

}