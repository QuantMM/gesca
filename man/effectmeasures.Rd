\name{effectmeasures}
\alias{effectmeasures}
\title{
Total and Indirect Effects of Variables
}
\description{
In the user-specified structural equation model, this function calculates the total and indirect effects of (1) latent variables on other latent variables in the structural model and (2) latent variables on their indicators in the measurement model.
}
\usage{
effectmeasures(object)
}
\arguments{
  \item{object}{
    An object of class. This can be created via the \code{\link{gesca.run}} function.
  }
}
\details{
The bootstrapped standard errors will be provided for all total and indirect effects. The user can specify the number of bootstrap samples via the \code{\link{gesca.run}} function. If the number of bootstrap samples is equal to 0, these standard errors will not be provided.
}
\value{
Four matrices whose row and column names are the same as the names of indicators and latent variables.
}
\references{
Hwang, H., & Takane, Y. (2014). Generalized Structured Component Analysis: A Component-Based Approach to Structural Equation Modeling (pp.119-123). Boca Raton, FL: Chapman & Hall/CRC Press.
}
\seealso{
\code{\link{gesca.run}}
}
\examples{
\dontrun{

library(gesca)
data(gesca.rick2) # Organizational identification example of Bagozzi

# Model specification
myModel <- "
		# Measurement model
		OP =~ cei1 + cei2 + cei3
		OI =~ ma1 + ma2 + ma3
		AC_J =~ orgcmt1 + orgcmt2 + orgcmt3
		AC_L =~ orgcmt5 + orgcmt6 + orgcmt8

		# Structural model
		OI ~ OP
		AC_J ~ OI
		AC_L ~ OI
"

# Run a multiple-group GSCA with the grouping variable gender:
GSCA.group <- gesca.run(myModel, gesca.rick2, group.name = "gender")
summary(GSCA.group)		# default output
effectmeasures(GSCA.group)	# total and indirect effects per group
GSCA.group.nbt0 <- gesca.run(myModel, gesca.rick2, group.name = "gender", nbt = 0)
effectmeasures(GSCA.group.nbt0)	# no bootstrapped standard error of parameters

# Second-order latent model with formative indicators
SndForm <- "
		# Measurement model
		OP(0) =~ cei1 + cei2 + cei3 + cei4 + cei5 + cei6 + cei7 + cei8
		OI(0) =~ ma1 + ma2 + ma3 + ma4 + ma5 + ma6
		AC_J(0) =~ orgcmt1 + orgcmt2 + orgcmt3 + orgcmt7
		AC_L(0) =~ orgcmt5 + orgcmt6 + orgcmt8

		# Second-order latents
		AC(0) =: AC_J + AC_L

		# Structural model
		OI ~ OP
		AC ~ OI
"

SndFormFit <- gesca.run(SndForm, gesca.rick2, "gender")
summary(SndFormFit)
effectmeasures(SndFormFit)
# Total/Indirect effects of latent variables on indicators
# will not be provided and instead, be reported as "NULL".

}
}
