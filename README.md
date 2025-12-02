# Variant Calling Pipeline

A standard Nextflow based bioinformatics pipeline that utilises a custom singularity image. The pipeline aligns using BWA, calls variants using bcftools and also makes read depth plots and variant plots for analyses. The pipeline is modular.

## Getting Started

You would need **NextFlow DSL2** and **Singularity** to use this pipeline. If you are using very large data you might need a HPC. The .config file has a SLURM profile which can be used on HPCs.

### Prerequisites

[NextFlow](https://www.nextflow.io/docs/latest/install.html#install-nextflow)

[Singularity](https://docs.sylabs.io/guides/2.6/user-guide/installation.html) 

You would also require a reference genome and a sample. For testing, I used the hg38 as the reference and a european lady's sample. 

### Installing

Download the singularity images i.e. the [containers]() folder. 

Download the [main.nf (pipeline file) ]() and the [nexflow configuration file]() 

Download the [modules]()

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

## The modules

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Billie Thompson** - *Initial work* - [PurpleBooth](https://github.com/PurpleBooth)

See also the list of [contributors](https://github.com/your/project/contributors) who participated in this project.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc
