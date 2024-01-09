\name{gesca.run}
\alias{gesca.run}
\title{
Fit Structural Equation Models using Generalized Structural Component Analysis
}
\description{
Fit a generalized structured component analysis (GSCA) model. gesca 1.0 can handle various extensions of GSCA, including imposing constraints on parameters, second-order latent variable modeling, multiple-group analysis, the calculation of total and indirect effects, and missing value imputation.
}
\usage{
gesca.run(myModel, data, group.name = NULL, group.equal = NULL,
          nbt = 100, itmax = 100, ceps = 1e-5,
          moption = 0, missingvalue = -9999)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{myModel}{
A simple description of the user-specified model using the gesca model syntax. The model can be described by strings or multiple lines of formulas. See Details and Examples below.
}
  \item{data}{
A data matrix or frame including the observed variables used in \preformatted{myModel}.
}
  \item{group.name}{
A character string only used in a multiple group analysis. A variable name in the data frame which defines the group membership of each case. The user can specify which variable is used to provide group memberships for a multiple group analysis. If \preformatted{NULL} (the default), a single-group GSCA will be run.
}
  \item{group.equal}{
A vector of character strings only used in a multiple group analysis. It can be one or both of the following: \preformatted{"loadings"} or \preformatted{"paths"}, specifying the pattern of equality constraints across multiple groups. The default is set to \preformatted{NULL} (the default), assuming that all parameters are freely estimated in each group. See Details and Examples below.
}
  \item{nbt}{
Denote the number of bootstrap samples. In gesca 1.0, the bootstrap method is employed to obtain the standard errors of parameter estimates. By default, \preformatted{nbt} is set to 100, but any non-negative numeric value can be used. If the number of bootstrap samples is equal to 0, only the values of parameter estimates obtained from the original dataset will be reported without their standard errors and CIs.
}
  \item{itmax}{
The maximum number of iterations for the alternating least-squares (ALS) algorithm. The default value is set to 100.
}
  \item{ceps}{
Convergence threshold for the ALS algorithm. The default is set to 0.00001.
}
  \item{moption}{
Options of handling missing data. By default, it is assumed that no value is missing in all variables. gesca 1.0 currently offers three options for handling missing data and the choice should be one of the following: list-wise deletion (\preformatted{moption = 1}), mean substitution (\preformatted{moption = 2}), and least-squares imputation (\preformatted{moption = 3}).
}
  \item{missingvalue}{
A missing value identifier. Only used if \preformatted{moption} is specified. By default, every element of \preformatted{-9999} in \preformatted{data} is defined as a missing value. Users can use any numeric or integer value to specify missing values in data. See Examples below.
}
}
\details{
\strong{General Overview of the gesca Model Syntax:}

In gesca 1.0, the user can write one or more formula lines to specify a structural equation model. This is the gesca model syntax for the \code{\link{gesca.run}} function. The model syntax consists of character strings or multiple lines of formulas as follows:

1) To specify the relationships between indicators and latent variables, the user can use the \preformatted{=~} operator. For example, the model syntax \preformatted{Y =~ X1 + X2 + X3} means the latent variable \preformatted{Y} is related to the indicators \preformatted{X1}, \preformatted{X2}, and \preformatted{X3}.

2) The relationships among latent variables can be expressed with the \preformatted{~} operator. For example, the syntax \preformatted{Y1 ~ Y2 + Y3} shows that \preformatted{Y1} is regressed on \preformatted{Y2} and \preformatted{Y3}.

3) The user can consider a second-order latent variable that is linked to a set of first-order latent variables. This can be described by the \preformatted{=:} operator. For example, the syntax \preformatted{H1 =: Y1+Y2+Y3} indicates that a second-order latent variable, \preformatted{H1}, is related to its lower-order latent variables \preformatted{Y1}, \preformatted{Y2}, and \preformatted{Y3}.

Importantly, the variable names in the gesca model syntax should correspond to the variable names in the data frame. If the option \preformatted{group.name} is used for a multiple-group GSCA, the same model structure is fitted across groups by default.


\strong{Constraining Parameters in the gesca Model Syntax:}

If the user wants to fix or constrain parameters to constants, it can be done in the gesca model syntax by adding values or labels followed by the \preformatted{*} operator. For example, in the following model syntax, the path coefficients of \preformatted{L1} regressed on \preformatted{L4} and of \preformatted{L4} regressed on \preformatted{L5} are fixed at 0.01 and 0.6, respectively:


\preformatted{myModel <- } "
\preformatted{    L1 =~ z1 + z2 + z3}
\preformatted{    L2 =~ z4 + z5 + z6}
\preformatted{    L3 =~ z7 + z8}
\preformatted{    L4 =~ z9 + z10 + z11}
\preformatted{    L5 =~ z12}
\preformatted{}
\preformatted{    L2 ~ L1}
\preformatted{    L3 ~ L1 + L2}
\preformatted{    L4 ~ 0.01*L1 + L2 + L3}
\preformatted{    L5 ~ 0.6*L4}
"

The above model is identical to the following model using labels (instead of values):


\preformatted{myModel <- } "
\preformatted{    L1 =~ z1 + z2 + z3}
\preformatted{    L2 =~ z4 + z5 + z6}
\preformatted{    L3 =~ z7 + z8}
\preformatted{    L4 =~ z9 + z10 + z11}
\preformatted{    L5 =~ z12}
\preformatted{}
\preformatted{    L2 ~ L1}
\preformatted{    L3 ~ L1 + L2}
\preformatted{    L4 ~ c1*L1 + L2 + L3}
\preformatted{    L5 ~ c2*L4}
\preformatted{}
\preformatted{    c1 == 0.01}
\preformatted{    c2 == 0.6}
"

\strong{Constraining Parameters in a Multiple-Group GSCA:}

Any across-group equality constraints can be imposed on parameters in the same way as above. In addition, the \preformatted{group.equal} option can be used to constrain all loadings and/or all path coefficients across groups simultaneously. To demonstrate the imposition of across-group equality constraints on all loadings and path coefficients, the user can simply input \preformatted{group.equal = c("loadings", "paths")}, then the \code{\link{gesca.run}} function estimates a single set of loadings and path coefficients that is fixed to be equal across groups. Similarly, \preformatted{group.equal = c("loadings")} treats all loadings to be fixed across all groups, and \preformatted{group.equal = c("paths")} returns identical path estimates in each group. See Examples for more details.


\strong{Reflective/Formative Indicators in the gesca Model Syntax:}

In gesca 1.0, the relationships between indicators and latent variables can be either reflective or formative and this can be defined by the operator \preformatted{(1)} or \preformatted{(0)}, respectively. The user can input these operators in the model syntax lines that contain the \preformatted{=~} and/or the \preformatted{=:} operators. If \preformatted{(1)} or \preformatted{(0)} argument is omitted, by default, the \code{\link{gesca.run}} function will treat all the relationships defined by \preformatted{=~} and/or \preformatted{=:} as reflective. For example, the model syntax \preformatted{Y =~ X1 + X2} or \preformatted{Y(1) =~ X1 + X2} means that \preformatted{X1} and \preformatted{X2} are reflective. Similarly, when the second-order latent variable has effects on its first-order latent variables, the relationship can be defined as \preformatted{H1 =: Y1+Y2} or \preformatted{H1(1) =: Y1+Y2}. On the other hand, if the first-order latent variables are considered formative, the model syntax is expressed as \preformatted{Y(0) =~ X1 + X2}, which involves no loadings for \preformatted{X1} and \preformatted{X2}.


\strong{Missing Value Imputation:}

To use the missing value identifier of the \code{\link{gesca.run}} function, missing values in the data frame should be represented by numeric codes (e.g. -9999, 99, -9) and specified by the \preformatted{missingvalue} option. This can be used only when the \preformatted{moption} argument is used. If the data have missing value codes but the user omits the \preformatted{missingvalue} argument, the \code{\link{gesca.run}} function will treat the missing values as regular data values (except for the value of -9999 by default).
}
\value{
An object of class \preformatted{gesca.run}, for which a summary method and four functions in gesca 1.0 (\code{\link{effectmeasures}}, \code{\link{fitmeasures}}, \code{\link{latentmeasures}}, and \code{\link{qualmeasures}}) are available.
}
\references{
Hwang, H., & Takane, Y. (2014). Generalized structured component analysis: A Component-Based Approach to Structural Equation Modeling (pp.13-126). Boca Raton, FL: Chapman & Hall/CRC Press.
}
\examples{

library(gesca)
data(gesca.rick2) # Organizational identification example of Bagozzi
                  # has the grouping variable "gender"

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

# In case the user wants to apply a single-group analysis ignoring the group information:
# rick2.GSCA <- gesca.run(myModel, gesca.rick2)

# Run a multiple-group GSCA with the grouping variable gender:
# GSCA.group <- gesca.run(myModel, gesca.rick2, group.name = "gender")
# summary(GSCA.group)
GSCA.group.nbt0 <- gesca.run(myModel, gesca.rick2, group.name ="gender", nbt = 0)
summary(GSCA.group.nbt0)		# no bootstrapped std errors
effectmeasures(GSCA.group.nbt0)

# Models with the imposition of constraints on parameters across groups
# (1) equality constraints
# equl.cstr <- gesca.run(myModel, gesca.rick2, group.name ="gender",
#                  group.equal = c("loadings", "paths"))

# (2) identical loadings but different path coefficients
# equl.loadings <- gesca.run(myModel, gesca.rick2, group.name ="gender",
#                      group.equal = c("loadings"))

# (3) More constraints across groups with some formative indicators
myModel.con <- "
		OP =~ cei1 + cei2 + cei3
		OI(0) =~ ma1 + ma2 + ma3
		AC_J =~ c(g,g)*orgcmt1 + c(h,h)*orgcmt2 + c(i,i)*orgcmt3
		AC_L(0) =~ orgcmt5 + orgcmt6 + orgcmt8

		OI ~ 0.37*OP
		AC_J ~ OI
		AC_L ~ OI
"
Const.Form <- gesca.run(myModel.con, gesca.rick2, group.name ="gender", nbt = 50)
summary(Const.Form)


# Second-order latent variable modeling
myModel5 <- "
		# Measurement model
		OP =~ cei1 + cei2 + cei3 + cei4 + cei5 + cei6 + cei7 + cei8
		OI =~ ma1 + ma2 + ma3 + ma4 + ma5 + ma6
		AC_J =~ orgcmt1 + orgcmt2 + orgcmt3 + orgcmt7
		AC_L =~ orgcmt5 + orgcmt6 + orgcmt8

		# Second-order latents
		AC =: AC_J + AC_L

		# Structural model
		OI ~ OP
		AC ~ OI
"

# second.GSCA <- gesca.run(myModel5, gesca.rick2, group.name = "gender")
# summary(second.GSCA)
second.GSCA.nbt0 <- gesca.run(myModel5, gesca.rick2, group.name = "gender", nbt=0)
summary(second.GSCA.nbt0)

}
