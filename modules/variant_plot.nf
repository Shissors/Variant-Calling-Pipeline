process VARIANT_PLOT{
	tag "$sample_id"
	container "./containers/variant_image.sif"
	
	input:
	tuple val(sample_id), path(tsv_file)

	output:
		path("${sample_id}_plots")

	publishDir "./results", mode: 'copy', overwrite: true


	script:
	"""
	mkdir -p ${sample_id}_plots
	
	
	
	python3 << 'EOF'

	import pandas as pd
	import plotly.express as px
	
	df = pd.read_csv("${tsv_file}", sep="\\t", names=['CHROM','POS','REF','ALT','QUAL','DP'])
	df['TYPE'] = df['REF'].str.len().eq(df['ALT'].str.len()).map({True:'SNP', False:'INDEL'})

	fig1 = px.line(df, x='POS', y='DP', title='Read Depth')
	fig1.write_html("${sample_id}_plots/depth_plot.html")

	fig2 = px.scatter(df, x='POS', y='QUAL', color='TYPE', hover_data=['REF','ALT'], title='Variants along genome')
	fig2.write_html("${sample_id}_plots/variants_scatter.html")
	EOF
    	"""
}

