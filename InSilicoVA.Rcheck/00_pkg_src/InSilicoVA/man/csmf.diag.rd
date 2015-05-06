\name{csmf.diag}
\alias{csmf.diag}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Convergence test for fitted InSilico model}
\description{
Produce convergence test for CSMFs from fitted \code{"insilico"} objects.
}
\usage{
csmf.diag(csmf, conv.csmf = 0.02, test= c("gelman", "heidel")[2], verbose = TRUE, 
          autoburnin = FALSE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{csmf}{It could be either fitted \code{"insilico"} object, a list of fitted \code{"insilico"} object from different chains of the same length but different starting values, i.e., different seed. Or it could be the matrix of CSMF obtained by \code{insilico}, or the list of matrices of CSMF. All CSMF could contain more than one subpopulations, but should be in the same format and order.}
  \item{conv.csmf}{The minimum mean CSMF to be checked. Default to be 0.02, which means any causes with mean CSMF lower than 0.02 will not be tested.}
  \item{test}{Type of test. Currently supporting Gelman and Rubin's test (\code{test = "gelman"}) for multi-chain test, and Heidelberger and Welch's test (\code{test = "heidel"}) for single-chain test. }
  \item{verbose}{Logical indicator to return the test detail instead of one logical outcome for Heidelberger and Welch's test. Default to be TRUE.}
  \item{autoburnin}{Logical indicator of whether to omit the first half of the chain as burn in. Default to be FALSE since \code{insilico} return only the iterations after burnin by default.}
  \item{\dots}{Arguments to be passed to \link{heidel.diag} or \link{gelman.diag}}
}

\details{
The tests are performed using \link{heidel.diag} and \link{gelman.diag} functions in \code{coda} package. The function takes either one or a list of output from \code{insilico} function, or only the iteration by CSMF matrix. Usually in practice, many causes with very tiny CSMF are hard to converge based on standard tests, thus it is suggested to check convergence for only causes with mean CSMF over certain threshold by setting proper \code{conv.csmf}.

Note for Gelman and Rubin's test, all chains should have the same length. If the chains are sampled with automatically length determination, they might not be comparable by this test.
}


\author{
Zehang Li, Tyler McCormick, Sam Clark

Maintainer: Zehang Li <lizehang@uw.edu>

}
\references{
Tyler H. McCormick, Zehang R. Li, Clara Calvert, Amelia C. Crampin, Kathleen Kahn and Samuel J. Clark Probabilistic cause-of-death assignment using verbal autopsies, \emph{arXiv preprint arXiv:1411.3042} \url{http://arxiv.org/abs/1411.3042} (2014)

Gelman, Andrew, and Donald B. Rubin. Inference from iterative simulation using multiple sequences. \emph{Statistical science} (1992): 457-472.

Brooks, Stephen P., and Andrew Gelman. General methods for monitoring convergence of iterative simulations. \emph{Journal of computational and graphical statistics} 7.4 (1998): 434-455.

Heidelberger, Philip, and Peter D. Welch. A spectral method for confidence interval generation and run length control in simulations. \emph{Communications of the ACM} 24.4 (1981): 233-245.


Heidelberger, Philip, and Peter D. Welch. Simulation run length control in the presence of an initial transient. \emph{Operations Research} 31.6 (1983): 1109-1144.

Schruben, Lee W. Detecting initialization bias in simulation output. \emph{Operations Research} 30.3 (1982): 569-590.
}
\keyword{ InSilicoVA }


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{insilico}}, \code{\link{summary.insilico}}
}
\examples{
# load sample data together with sub-population list
data(SampleInput_insilico)
\dontrun{
# extract INterVA style input data
data <- SampleInput_insilico$data
# extract sub-population information. 
# The groups are "HIV Positive", "HIV Negative" and "HIV status unknown".
subpop <- SampleInput_insilico$subpop

# run without sub-population
fit1a<- insilico( data, subpop = NULL, 
              length.sim = 400, burnin = 200, thin = 10 , seed = 1, 
              auto.length = FALSE)
fit1b<- insilico( data, subpop = NULL,  
              length.sim = 400, burnin = 200, thin = 10 , seed = 2, 
              auto.length = FALSE)
fit1c<- insilico( data, subpop = NULL,  
              length.sim = 400, burnin = 200, thin = 10 , seed = 3, 
              auto.length = FALSE)
# single chain check
csmf.diag(fit1a)
# equivalent way of check one chain
csmf.diag(fit1a$csmf)

# multiple chains check
csmf.diag(list(fit1a, fit1b, fit1c), test = "gelman")
# equivalent way of check one chain
csmf.diag(list(fit1a$csmf, fit1b$csmf, fit1c$csmf), test = "gelman")


# with sub-populations
fit2a<- insilico( data, subpop = subpop,  
              length.sim = 400, burnin = 200, thin = 10 , seed = 1, 
              auto.length = FALSE)
fit2b<- insilico( data, subpop = subpop,  
              length.sim = 400, burnin = 200, thin = 10 , seed = 2, 
              auto.length = FALSE)
fit2c<- insilico( data, subpop = subpop,   
              length.sim = 400, burnin = 200, thin = 10 , seed = 3, 
              auto.length = FALSE)

# single chain check
csmf.diag(fit2a)
# equivalent way of check one chain
csmf.diag(fit2a$csmf)

# multiple chains check
csmf.diag(list(fit2a, fit2b, fit2c), test = "gelman")
# equivalent way of check one chain
csmf.diag(list(fit2a$csmf, fit2b$csmf, fit2c$csmf), test = "gelman")
}

}
