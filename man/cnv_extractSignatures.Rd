% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cnv_main.R
\name{cnv_extractSignatures}
\alias{cnv_extractSignatures}
\alias{signatures}
\title{Extract signature based on specified rank value}
\usage{
cnv_extractSignatures(sample_by_component, nsig, seed = 123456,
  nmfalg = "brunet", cores = 1)
}
\arguments{
\item{sample_by_component}{a sample-by-component \code{matrix}, generate from \link{cnv_generateSbCMatrix} function.}

\item{nsig}{specification of the factorization rank.}

\item{seed}{seed number.}

\item{nmfalg}{specification of the NMF algorithm.}

\item{cores}{number of compute cores to run this task.
You can use \code{\link[parallel:detectCores]{parallel::detectCores()}} function to check how
many cores you can use. If you are using \code{\link[=cnv_pipe]{cnv_pipe()}} feature,
please do not use maximal number of
cores in your computer, it may cause some unexpected problems.}
}
\value{
a object of \code{NMF} run.
}
\description{
Extract signature based on specified rank value
}
\examples{
\dontrun{
## load example copy-number data from tcga
load(system.file("inst/extdata", "example_cn_list.RData", package = "VSHunter"))
## generate copy-number features
tcga_features = cnv_derivefeatures(CN_data = tcga_segTabs, cores = 1, genome_build = "hg19")
## fit mixture model  (this will take some time)
tcga_components = cnv_fitMixModels(CN_features = tcga_features, cores = 1)
## generate a sample-by-component matrix
tcga_sample_component_matrix = cnv_generateSbCMatrix(tcga_features, tcga_components, cores = 1)
## optimal rank survey
 tcga_sig_choose = cnv_chooseSigNumber(tcga_sample_component_matrix, nrun = 10,
 cores = 1, plot = FALSE)
 tcga_signatures = cnv_extractSignatures(tcga_sample_component_matrix, nsig = 3, cores = 1)
}
}
\seealso{
\code{\link[=cnv_plotSignatures]{cnv_plotSignatures()}} for plot signatures and their contributions.

Other CNV analysis functions: \code{\link{cnv_autoCaptureSignatures}},
  \code{\link{cnv_chooseSigNumber}},
  \code{\link{cnv_derivefeatures}},
  \code{\link{cnv_fitMixModels}},
  \code{\link{cnv_generateSbCMatrix}},
  \code{\link{cnv_getLengthFraction}},
  \code{\link{cnv_pipe}},
  \code{\link{cnv_plotDistributionProfile}},
  \code{\link{cnv_plotFeatureDistribution}},
  \code{\link{cnv_plotMixComponents}},
  \code{\link{cnv_plotSignatures}},
  \code{\link{cnv_quantifySigExposure}},
  \code{\link{cnv_readprofile}}
}
\author{
Geoffrey Macintyre, Shixiang Wang
}
\concept{CNV analysis functions}
\keyword{signature}
