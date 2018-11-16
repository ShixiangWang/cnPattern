
<!-- README.md is generated from README.Rmd. Please edit that file -->
cnPattern: Decode Pattern of Copy Number Profile
================================================

[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/ShixiangWang/cnPattern?branch=master&svg=true)](https://ci.appveyor.com/project/ShixiangWang/cnPattern)

The goal of cnPattern is to decode copy number pattern from **absolute copy number profile**. This package collects R code from paper *[Copy number signatures and mutational processes in ovarian carcinoma](https://www.nature.com/articles/s41588-018-0179-8)* and tidy them as a open source R package for bioinformatics community.

Before you use this tool, you have to obtain **absolute copy number profile** for samples via software like ABSOLUTE v2, QDNASeq etc..

Procedure
---------

1.  summarise copy-number profile using a number of different feature distributions:
    -   Sgement size
    -   Breakpoint number (per ten megabases)
    -   change-point copy-number
    -   Breakpoint number (per chromosome arm)
    -   Length of segments with oscillating copy-number
2.  apply mixture modelling to breakdown each feature distribution into mixtures of Gaussian or mixtures of Poisson distributions using the flexmix package.
3.  generate a sample-by-component matrix representing the sum of posterior probabilities of each copy-number event being assigned to each component.
4.  use NMF package to factorise the sample-by-component matrix into a signature-by-sample matrix and component-by signature-matrix.

<img src="https://media.springernature.com/m685/springer-static/image/art%3A10.1038%2Fs41588-018-0179-8/MediaObjects/41588_2018_179_Fig1_HTML.png" alt="Copy number signature identification, Macintyre, Geoff, et al.(2018)"  />
<p class="caption">
Copy number signature identification, Macintyre, Geoff, et al.(2018)
</p>

Installation
------------

You can install UCSCXenaTools from github with:

``` r
# install.packages("devtools")
devtools::install_github("ShixiangWang/cnPattern", build_vignettes = TRUE)
```

Read this vignettes.

``` r
browseVignettes("cnPattern")
# or
??cnPattern
```

> update features and function will show in vignettes in the future

Load package.

``` r
library(cnPattern)
```

Usage
-----

Load example data:

``` r
load(system.file("inst/extdata", "example_cn_list.RData", package = "cnPattern"))
```

`tcga_segTabs` is a list contain absolute copy number profile for multiple samples, each sample is a `data.frame` in the list.

Derive feature distributions.

``` r
tcga_features = derive_features(CN_data = tcga_segTabs, cores = 4, genome_build = "hg19")
```

Fit model components.

``` r
tcga_components = fit_mixModels(CN_features = tcga_features, cores = 4)
```

Generate a sample-by-component matrix representing the sum of posterior probabilities of each copy-number event being assigned to each component.

``` r
tcga_sample_component_matrix = generate_sbcMatrix(tcga_features, tcga_components, cores = 4)
```

Choose optimal number of signatures.

``` r
tcga_sig_choose = choose_nSignatures(tcga_sample_component_matrix, nrun = 10, cores = 4)
```

Extract signatures.

``` r
tcga_signatures = extract_Signatures(tcga_sample_component_matrix, nsig = 3, cores = 4)
```

Quantify exposure for samples.

``` r
w = NMF::basis(tcga_signatures)
#h = NMF::coef(tcga_signatures)
tcga_exposure = quantify_Signatures(sample_by_component = tcga_sample_component_matrix, component_by_signature = w)
```

Function `autoCapture_Signatures()` finish three steps (choose best number of signatures, extract signatures and quantify exposure) above in an antomated way. The arguments of this function are same as `choose_nSignatures()`.

``` r
tcga_results = autoCapture_Signatures(tcga_sample_component_matrix, nrun=10, cores = 4)
```

The result object is a `list` which contains all results need fro downstream analysis, include NMF result related to best rank value, signature matrix, absolute and relative exposure (contribution) and best rank survey etc..

Citation
--------

-   *Macintyre, Geoff, et al. "Copy number signatures and mutational processes in ovarian carcinoma." Nature genetics 50.9 (2018): 1262.*

If you wanna thanks for my work of this package, you can also cite:

-   *Wang, Shixiang, et al. "APOBEC3B and APOBEC mutational signature as potential predictive markers for immunotherapy response in non-small cell lung cancer." Oncogene (2018).*