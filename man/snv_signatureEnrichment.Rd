% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/snv_main.R
\name{snv_signatureEnrichment}
\alias{snv_signatureEnrichment}
\title{Performs sample stratification based on signature contribution and enrichment analysis.}
\usage{
snv_signatureEnrichment(maf, sig_res, minMut = 5, useCNV = FALSE,
  fn = NULL)
}
\arguments{
\item{maf}{an \code{\link{MAF}} object used for signature analysis.}

\item{sig_res}{Signature results from \code{\link{extractSignatures}}}

\item{minMut}{Consider only genes with minimum this number of samples mutated. Default 5.}

\item{useCNV}{whether to include copy number events. Only applicable when MAF is read along with copy number data. Default TRUE if available.}

\item{fn}{basename for output file. Default NULL.}
}
\value{
result list containing p-values
}
\description{
Performs k-means clustering to assign signature to samples and performs enrichment analysis.
}
\examples{
\dontrun{
laml.tnm <- snv_trinucleotideMatrix(maf = laml, ref_genome = 'BSgenome.Hsapiens.UCSC.hg19',
    prefix = 'chr', add = TRUE, useSyn = TRUE)
laml.sign <- snv_extractSignatures(mat = laml.tnm, plotBestFitRes = FALSE)
}
}
\seealso{
Other SNV analysis functions: \code{\link{snv_extractSignatures}},
  \code{\link{snv_plotSignatures}},
  \code{\link{snv_readprofile}},
  \code{\link{snv_trinucleotideMatrix}}
}
\concept{SNV analysis functions}
