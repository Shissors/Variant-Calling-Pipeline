# Variant Calling Pipeline

A standard Nextflow based bioinformatics pipeline that utilises a custom singularity image. The pipeline aligns using BWA, calls variants using bcftools and also makes read depth plots and variant plots for analyses. The pipeline is modular.

## Getting Started

You would need **NextFlow DSL2** and **Singularity** to use this pipeline. If you are using very large data you might need a HPC. The .config file has a SLURM profile which can be used on HPCs.

### Prerequisites

[NextFlow](https://www.nextflow.io/docs/latest/install.html#install-nextflow)

[Singularity](https://docs.sylabs.io/guides/2.6/user-guide/installation.html) 

You would also require a reference genome and a sample. For testing, I used the hg38 as the reference and a european lady's sample. 

### Installing

Download the singularity images i.e. the [containers](https://github.com/Shissors/Variant-Calling-Pipeline/tree/main/containers) folder. The files here are .def files which must be first converted to .sif files. This can be only done if you have root access to the HPC or you can do it locally as well. Use the command to get a .def file

You would also need 2 other images. [bcftools](https://hub.docker.com/r/biocontainers/bcftools)  and  [Samtools](https://hub.docker.com/r/biocontainers/samtools)

Put all these images in the containers folders.


```
sudo singularity build variant_image.sif variant_image.def
```


Download the [main.nf (pipeline file) ]() and the [nexflow configuration file]() 

Download the [modules](https://github.com/Shissors/Variant-Calling-Pipeline/tree/main/modules)

I also recommend using the same directory setup i.e. adding the results and data folders. The data folder contains your input files and the results folder contains the final results.

## Running the Pipeline

After everything is downloaded. Use the following command

```
nextflow run main.nf -profile <slurm if using> --reads ./data/<sample.fastq.gz> --reference ./data/<reference.fa>  --outdir ./results

```

This should run the pipeline. Now the only changes I had to make, was in the [bcftools_view]() module, depending on the type of sample.

```
bcftools call -mv --ploidy <change this depending on the sample> -Oz -o ${sample_id}.calls.vcf.gz ${raw_bcf}

```
Depending on your sample the ploidy might be different. For more info. Go [here](https://samtools.github.io/bcftools/bcftools.html)

## The Pipeline

![ ](https://github.com/Shissors/Varaint-Calling-Pipeline/blob/main/Pipeline_Diagram.jpg)



## Output Plots


![The Read Depth Plot, showing the Position of Sequence (POS) on X axis and Read Depth (DP) on the Y axis, higher depth -> better coverage -> better quality](https://github.com/Shissors/Varaint-Calling-Pipeline/blob/main/read_depth.png)

The Read Depth Plot, showing the Position of Sequence (POS) on X axis and Read Depth (DP) on the Y axis, higher depth -> better coverage -> better quality

![The variant plot, shows SNPs and INDELs along the genome. The quality on the Y axis and POS on the X axis. Higher quality -> More reliable result](https://github.com/Shissors/Varaint-Calling-Pipeline/blob/main/variant.png)


The variant plot, shows SNPs and INDELs along the genome. The quality on the Y axis and POS on the X axis. Higher quality -> More reliable result


