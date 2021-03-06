# Generated by using Rcpp::compileAttributes() -> do not edit by hand
# Generator token: 10BE3573-1514-4C36-9D1C-5A225CD40393

#' Construct a copula using uniform sampling from the unit simplex
#'
#' Given two families of parallel hyperplanes or a family of parallel hyperplanes and a family of concentric ellispoids centered at the origin intersecting the canonical simplex, this function uniformly samples from the canonical simplex and construct an approximation of the bivariate probability distribution, called copula.
#'
#' @param r1 A \eqn{d}-dimensional vector that describes the direction of the first family of parallel hyperplanes.
#' @param r2 Optional. A \eqn{d}-dimensional vector that describes the direction of the second family of parallel hyperplanes.
#' @param sigma Optional. The \eqn{d\times d} symmetric positive semidefine matrix that describes the family of concentric ellipsoids centered at the origin.
#' @param m The number of the slices for the copula. The default value is 100.
#' @param n The number of points to sample. The default value is \eqn{5\cdot 10^5}.
#'
#' @references \cite{L. Cales, A. Chalkis, I.Z. Emiris, V. Fisikopoulos,
#' \dQuote{Practical volume computation of structured convex bodies, and an application to modeling portfolio dependencies and financial crises,} \emph{Proc. of Symposium on Computational Geometry, Budapest, Hungary,} 2018.}
#'
#' @return A \eqn{numSlices\times numSlices} numerical matrix that corresponds to a copula.
#' @examples
#' # compute a copula for two random families of parallel hyperplanes
#' h1 = runif(n = 10, min = 1, max = 1000)
#' h1 = h1 / 1000
#' h2=runif(n = 10, min = 1, max = 1000)
#' h2 = h2 / 1000
#' cop = copula(r1 = h1, r2 = h2, m = 10, n = 100000)
#'
#' # compute a copula for a family of parallel hyperplanes and a family of conentric ellipsoids
#' h = runif(n = 10, min = 1, max = 1000)
#' h = h / 1000
#' E = replicate(10, rnorm(20))
#' E = cov(E)
#' cop = copula(r1 = h, sigma = E, m = 10, n = 100000)
#'
#' @export
copula <- function(r1 = NULL, r2 = NULL, sigma = NULL, m = NULL, n = NULL) {
    .Call(`_volesti_copula`, r1, r2, sigma, m, n)
}

#' Compute the exact volume of (a) a zonotope (b) an arbitrary simplex in V-representation or (c) if the volume is known and declared by the input object.
#'
#' Given a zonotope (as an object of class Zonotope), this function computes the sum of the absolute values of the determinants of all the \eqn{d \times d} submatrices of the \eqn{m\times d} matrix \eqn{G} that contains row-wise the \eqn{m} \eqn{d}-dimensional segments that define the zonotope.
#' For an arbitrary simplex that is given in V-representation this function computes the absolute value of the determinant formed by the simplex's points assuming it is shifted to the origin.
#'
#' @param P A polytope
#'
#' @return The exact volume of the input polytope, for zonotopes, simplices in V-representation and polytopes with known exact volume
#' @examples
#'
#' # compute the exact volume of a 5-dimensional zonotope defined by the Minkowski sum of 10 segments
#' Z = gen_rand_zonotope(5, 10)
#' vol = exact_vol(Z)
#'
#' \donttest{# compute the exact volume of a 2-d arbitrary simplex
#' V = matrix(c(2,3,-1,7,0,0),ncol = 2, nrow = 3, byrow = TRUE)
#' P = Vpolytope$new(V)
#' vol = exact_vol(P)
#' }
#'
#' # compute the exact volume the 10-dimensional cross polytope
#' P = gen_cross(10,'V')
#' vol = exact_vol(P)
#' @export
exact_vol <- function(P) {
    .Call(`_volesti_exact_vol`, P)
}

#' Compute the percentage of the volume of the unit simplex that is contained in the intersection of a half-space and the unit simplex.
#'
#' A half-space \eqn{H} is given as a pair of a vector \eqn{a\in R^d} and a scalar \eqn{z0\in R} s.t.: \eqn{a^Tx\leq z0}. This function calls the Ali's version of the Varsi formula to compute a frustum of the unit simplex.
#'
#' @param a A \eqn{d}-dimensional vector that defines the direction of the hyperplane.
#' @param z0 The scalar that defines the half-space.
#'
#' @references \cite{Varsi, Giulio,
#' \dQuote{The multidimensional content of the frustum of the simplex,} \emph{Pacific J. Math. 46, no. 1, 303--314,} 1973.}
#'
#' @references \cite{Ali, Mir M.,
#' \dQuote{Content of the frustum of a simplex,} \emph{ Pacific J. Math. 48, no. 2, 313--322,} 1973.}
#'
#' @return The percentage of the volume of the unit simplex that is contained in the intersection of a given half-space and the unit simplex.
#'
#' @examples
#' # compute the frustum of H: -x1+x2<=0
#' a=c(-1,1)
#' z0=0
#' frustum = frustum_of_simplex(a, z0)
#' @export
frustum_of_simplex <- function(a, z0) {
    .Call(`_volesti_frustum_of_simplex`, a, z0)
}

#' Compute an inscribed ball of a convex polytope
#'
#' For a H-polytope described by a \eqn{m\times d} matrix \eqn{A} and a \eqn{m}-dimensional vector \eqn{b}, s.t.: \eqn{Ax\leq b}, this function computes the largest inscribed ball (Chebychev ball) by solving the corresponding linear program.
#' For a V-polytope \eqn{d+1} vertices, that define a full dimensional simplex, picked at random and the largest inscribed ball of the simplex is computed.
#' For a zonotope \eqn{P} we compute the minimum \eqn{r} s.t.: \eqn{ r e_i \in P} for all \eqn{i=1, \dots ,d}. Then the ball centered at the origin with radius \eqn{r/ \sqrt{d}} is an inscribed ball.
#'
#' @param P A convex polytope. It is an object from class (a) Hpolytope or (b) Vpolytope or (c) Zonotope.
#'
#' @return A \eqn{d+1}-dimensional vector that describes the inscribed ball. The first \eqn{d} coordinates corresponds to the center of the ball and the last one to the radius.
#'
#' @examples
#' # compute the Chebychev ball of the 2d unit simplex
#' P = gen_simplex(2,'H')
#' ball_vec = inner_ball(P)
#'
#' # compute an inscribed ball of the 3-dimensional unit cube in V-representation
#' P = gen_cube(3, 'V')
#' ball_vec = inner_ball(P)
#' @export
inner_ball <- function(P) {
    .Call(`_volesti_inner_ball`, P)
}

#' An internal Rccp function as a polytope generator
#'
#' @param kind_gen An integer to declare the type of the polytope.
#' @param Vpoly_gen A boolean parameter to declare if the requested polytope has to be in V-representation.
#' @param dim_gen An integer to declare the dimension of the requested polytope.
#' @param m_gen An integer to declare the number of generators for the requested random zonotope.
#'
#' @section warning:
#' Do not use this function.
#'
#' @return A numerical matrix describing the requested polytope
poly_gen <- function(kind_gen, Vpoly_gen, Zono_gen, dim_gen, m_gen) {
    .Call(`_volesti_poly_gen`, kind_gen, Vpoly_gen, Zono_gen, dim_gen, m_gen)
}

#'  An internal Rccp function for the random rotation of a convex polytope
#'
#' @param P A convex polytope (H-, V-polytope or a zonotope).
#'
#' @section warning:
#' Do not use this function.
#'
#' @return A matrix that describes the rotated polytope
rotating <- function(P) {
    .Call(`_volesti_rotating`, P)
}

#' Internal rcpp function for the rounding of a convex polytope
#'
#' @param P A convex polytope (H- or V-representation or zonotope).
#' @param random_walk Optional. A string that declares the random walk.
#' @param walk_length Optional. The number of the steps for the random walk.
#' @param parameters Optional. A list for the parameters of the methods:
#'
#' @section warning:
#' Do not use this function.
#'
#' @return A numerical matrix that describes the rounded polytope and contains the round value.
rounding <- function(P, random_walk = NULL, walk_length = NULL, parameters = NULL) {
    .Call(`_volesti_rounding`, P, random_walk, walk_length, parameters)
}

#' Sample points from a convex Polytope (H-polytope, V-polytope or a zonotope) or use direct methods for uniform sampling from the unit or the canonical or an arbitrary \eqn{d}-dimensional simplex and the boundary or the interior of a \eqn{d}-dimensional hypersphere
#'
#' Sample N points with uniform or multidimensional spherical gaussian -centered in an internal point- target distribution.
#' The \eqn{d}-dimensional unit simplex is the set of points \eqn{\vec{x}\in \R^d}, s.t.: \eqn{\sum_i x_i\leq 1}, \eqn{x_i\geq 0}. The \eqn{d}-dimensional canonical simplex is the set of points \eqn{\vec{x}\in \R^d}, s.t.: \eqn{\sum_i x_i = 1}, \eqn{x_i\geq 0}.
#'
#' @param P A convex polytope. It is an object from class (a) Hpolytope or (b) Vpolytope or (c) Zonotope.
#' @param N The number of points that the function is going to sample from the convex polytope. The default value is \eqn{100}.
#' @param distribution Optional. A string that declares the target distribution: a) \code{'uniform'} for the uniform distribution or b) \code{'gaussian'} for the multidimensional spherical distribution. The default target distribution is uniform.
#' @param random_walk Optional. A string that declares the random walk method: a) \code{'CDHR'} for Coordinate Directions Hit-and-Run, b) \code{'RDHR'} for Random Directions Hit-and-Run, c) \code{'BaW'} for Ball Walk or d) \code{'BiW'} for Billiard walk. The default walk is \code{'BiW'} for the uniform distribution or \code{'CDHR'} for the Normal distribution.
#' @param walk_length Optional. The number of the steps for the random walk. The default value is \eqn{1} for \code{'BiW'} and \eqn{\lfloor 10 + d/10\rfloor} otherwise, where \eqn{d} is the dimension that the polytope lies.
#' @param exact A boolean parameter. It should be used for the uniform sampling from the boundary or the interior of a hypersphere centered at the origin or from the unit or the canonical or an arbitrary simplex. The arbitrary simplex has to be given as a V-polytope. For the rest well known convex bodies the dimension has to be declared and the type of body as well as the radius of the hypersphere.
#' @param body A string that declares the type of the body for the exact sampling: a) \code{'unit simplex'} for the unit simplex, b) \code{'canonical simplex'} for the canonical simplex, c) \code{'hypersphere'} for the boundary of a hypersphere centered at the origin, d) \code{'ball'} for the interior of a hypersphere centered at the origin.
#' @param parameters Optional. A list for the parameters of the methods:
#' \itemize{
#' \item{\code{variance} }{ The variance of the multidimensional spherical gaussian. The default value is 1.}
#' \item{\code{dimension} }{ An integer that declares the dimension when exact sampling is enabled for a simplex or a hypersphere.}
#' \item{\code{radius} }{ The radius of the \eqn{d}-dimensional hypersphere. The default value is \eqn{1}.}
#' \item{\code{BW_rad} }{ The radius for the ball walk.}
#' \item{\code{L} }{The maximum length of the billiard trajectory.}
#' }
#' @param InnerPoint A \eqn{d}-dimensional numerical vector that defines a point in the interior of polytope P.
#'
#' @references \cite{R.Y. Rubinstein and B. Melamed,
#' \dQuote{Modern simulation and modeling} \emph{ Wiley Series in Probability and Statistics,} 1998.}
#' @references \cite{A Smith, Noah and W Tromble, Roy,
#' \dQuote{Sampling Uniformly from the Unit Simplex,} \emph{ Center for Language and Speech Processing Johns Hopkins University,} 2004.}
#' @references \cite{Art B. Owen,
#' \dQuote{Monte Carlo theory, methods and examples,} \emph{ Art Owen,} 2009.}
#'
#' @return A \eqn{d\times N} matrix that contains, column-wise, the sampled points from the convex polytope P.
#' @examples
#' # uniform distribution from the 3d unit cube in V-representation using ball walk
#' P = gen_cube(3, 'V')
#' points = sample_points(P, random_walk = "BaW", walk_length = 5)
#'
#' # gaussian distribution from the 2d unit simplex in H-representation with variance = 2
#' A = matrix(c(-1,0,0,-1,1,1), ncol=2, nrow=3, byrow=TRUE)
#' b = c(0,0,1)
#' P = Hpolytope$new(A,b)
#' points = sample_points(P, distribution = "gaussian", parameters = list("variance" = 2))
#'
#' # uniform points from the boundary of a 10-dimensional hypersphere
#' points = sample_points(exact = TRUE, body = "hypersphere", parameters = list("dimension" = 10))
#'
#' # 10000 uniform points from a 2-d arbitrary simplex
#' V = matrix(c(2,3,-1,7,0,0),ncol = 2, nrow = 3, byrow = TRUE)
#' P = Vpolytope$new(V)
#' points = sample_points(P, N = 10000, exact = TRUE)
#' @export
sample_points <- function(P = NULL, N = NULL, distribution = NULL, random_walk = NULL, walk_length = NULL, exact = NULL, body = NULL, parameters = NULL, InnerPoint = NULL) {
    .Call(`_volesti_sample_points`, P, N, distribution, random_walk, walk_length, exact, body, parameters, InnerPoint)
}

#' The main function for volume approximation of a convex Polytope (H-polytope, V-polytope or a zonotope)
#'
#' For the volume approximation can be used two algorithms. Either SequenceOfBalls or CoolingGaussian. A H-polytope with \eqn{m} facets is described by a \eqn{m\times d} matrix \eqn{A} and a \eqn{m}-dimensional vector \eqn{b}, s.t.: \eqn{Ax\leq b}. A V-polytope is defined as the convex hull of \eqn{m} \eqn{d}-dimensional points which correspond to the vertices of P. A zonotope is desrcibed by the Minkowski sum of \eqn{m} \eqn{d}-dimensional segments.
#'
#' @param P A convex polytope. It is an object from class (a) Hpolytope or (b) Vpolytope or (c) Zonotope.
#' @param walk_length Optional. The number of the steps for the random walk. The default value is \eqn{\lfloor 10 + d/10\rfloor} for SequenceOfBalls and \eqn{1} otherwise.
#' @param error Optional. Declare the upper bound for the approximation error. The default value is \eqn{1} for SequenceOfBalls and \eqn{0.1} otherwise.
#' @param inner_ball Optional. A \eqn{d+1} vector that contains an inner ball. The first \eqn{d} coordinates corresponds to the center and the last one to the radius of the ball. If it is not given then for H-polytopes the Chebychev ball is computed, for V-polytopes \eqn{d+1} vertices are picked randomly and the Chebychev ball of the defined simplex is computed. For a zonotope that is defined by the Minkowski sum of \eqn{m} segments we compute the maximal \eqn{r} s.t.: \eqn{re_i\in Z} for all \eqn{i=1,\dots ,d}, then the ball centered at the origin with radius \eqn{r/\sqrt{d}} is an inscribed ball.
#' @param algo Optional. A string that declares which algorithm to use: a) \code{'SoB'} for SequenceOfBalls or b) \code{'CG'} for CoolingGaussian or c) \code{'CB'} for cooling bodies.
#' @param random_walk Optional. A string that declares the random walk method: a) \code{'CDHR'} for Coordinate Directions Hit-and-Run, b) \code{'RDHR'} for Random Directions Hit-and-Run, c) \code{'BaW'} for Ball Walk, or \code{'BiW'} for Billiard walk. The default walk is \code{'CDHR'} for H-polytopes and \code{'BiW'} for the other representations.
#' @param rounding Optional. A boolean parameter for rounding. The default value is \code{TRUE} for V-polytopes and \code{FALSE} otherwise.
#' @param parameters Optional. A list for the parameters of the algorithms:
#' \itemize{
#' \item{\code{Window} }{ The length of the sliding window for CG algorithm. The default value is \eqn{500+4dimension^2}.}
#'  \item{\code{C} }{ A constant for the lower bound of \eqn{variance/mean^2} in schedule annealing of CG algorithm. The default value is \eqn{2}.}
#'  \item{\code{M} }{ The number of points we sample in each step of schedule annealing in CG algorithm. The default value is \eqn{500C + dimension^2 / 2}.}
#'  \item{\code{ratio} }{ Parameter of schedule annealing of CG algorithm, larger ratio means larger steps in schedule annealing. The default value is \eqn{1 - 1/dimension}.}
#'  \item{\code{frac} }{ The fraction of the total error to spend in the first gaussian in CG algorithm. The default value is \eqn{0.1}.}
#'  \item{\code{BW_rad} }{ The radius for the ball walk. The default value is \eqn{4r/dimension}, where \eqn{r} is the radius of the inscribed ball of the polytope.}
#'  \item{\code{ub} }{ The lower bound for the ratios in MMC in CB algorithm. The default value is \eqn{0.1}.}
#'  \item{\code{lb} }{ The upper bound for the ratios in MMC in CB algorithm. The default value is \eqn{0.15}.}
#'  \item{\code{N} }{ An integer that controls the number of points \eqn{\nu N} generated in each convex body in annealing schedule of algorithm CB.}
#'  \item{\code{nu} }{ The degrees of freedom for the t-student distribution in t-tests in CB algorithm. The default value is \eqn{10}.}
#'  \item{\code{alpha} }{ The significance level for the t-tests in CB algorithm. The default values is 0.2.}
#'  \item{\code{prob} }{ The probability is used for the empirical confidence interval in ratio estimation of CB algorithm. The default value is \eqn{0.75}.}
#'  \item{\code{hpoly} }{ A boolean parameter to use H-polytopes in MMC of CB algorithm. The default value is \code{FALSE}.}
#'  \item{\code{minmaxW} }{ A boolean parameter to use the sliding window with a minmax values stopping criterion.}
#'  \item{\code{L} }{The maximum length of the billiard trajectory.}
#' }
#'
#' @references \cite{I.Z.Emiris and V. Fisikopoulos,
#' \dQuote{Practical polytope volume approximation,} \emph{ACM Trans. Math. Soft.,} 2014.},
#' @references \cite{A. Chalkis and I.Z.Emiris and V. Fisikopoulos,
#' \dQuote{Practical Volume Estimation by a New Annealing Schedule for Cooling Convex Bodies,} \emph{CoRR, abs/1905.05494,} 2019.},
#' @references \cite{B. Cousins and S. Vempala, \dQuote{A practical volume algorithm,} \emph{Springer-Verlag Berlin Heidelberg and The Mathematical Programming Society,} 2015.}
#'
#'
#' @return The approximation of the volume of a convex polytope.
#' @examples
#' # calling SOB algorithm for a H-polytope (2d unit simplex)
#' P = gen_simplex(2,'H')
#' vol = volume(P)
#'
#' # calling CG algorithm for a V-polytope (3d simplex)
#' P = gen_simplex(2,'V')
#' vol = volume(P, algo = "CG")
#'
#' # calling CG algorithm for a 2-dimensional zonotope defined as the Minkowski sum of 4 segments
#' Z = gen_rand_zonotope(2, 4)
#' vol = volume(Z, random_walk = "RDHR", walk_length = 5)
#' @export
volume <- function(P, walk_length = NULL, error = NULL, inner_ball = NULL, algo = NULL, random_walk = NULL, rounding = NULL, parameters = NULL) {
    .Call(`_volesti_volume`, P, walk_length, error, inner_ball, algo, random_walk, rounding, parameters)
}

#' An internal Rccp function for the over-approximation of a zonotope
#'
#' @param Z A zonotope.
#' @param fit_ratio Optional. A boolean parameter to request the computation of the ratio of fitness.
#' @param walk_length Optional. The number of the steps for the random walk. The default value is \eqn{\lfloor 10 + d/10\rfloor} for SequenceOfBalls and \eqn{1} for CoolingGaussian.
#' @param error Optional. Declare the upper bound for the approximation error. The default value is \eqn{1} for SequenceOfBalls and \eqn{0.1} for CoolingGaussian.
#' @param inner_ball Optional. A \eqn{d+1} vector that contains an inner ball. The first \eqn{d} coordinates corresponds to the center and the last one to the radius of the ball. If it is not given then for H-polytopes the Chebychev ball is computed, for V-polytopes \eqn{d+1} vertices are picked randomly and the Chebychev ball of the defined simplex is computed. For a zonotope that is defined by the Minkowski sum of \eqn{m} segments we compute the maximal \eqn{r} s.t.: \eqn{re_i\in Z} for all \eqn{i=1,\dots ,d}, then the ball centered at the origin with radius \eqn{r/\sqrt{d}} is an inscribed ball.
#' @param random_walk Optional. A string that declares the random walk method: a) \code{'CDHR'} for Coordinate Directions Hit-and-Run, b) \code{'RDHR'} for Random Directions Hit-and-Run or c) \code{'BW'} for Ball Walk. The default walk is \code{'CDHR'}.
#' @param rounding Optional. A boolean parameter for rounding. The default value is \code{FALSE}.
#' @param parameters Optional. A list for the parameters of the volume algorithm
#'
#' @section warning:
#' Do not use this function.
#'
#' @return A List that contains a numerical matrix that describes the PCA approximation as a H-polytope and the ratio of fitness.
zono_approx <- function(Z, fit_ratio = NULL, walk_length = NULL, error = NULL, inner_ball = NULL, random_walk = NULL, rounding = NULL, parameters = NULL) {
    .Call(`_volesti_zono_approx`, Z, fit_ratio, walk_length, error, inner_ball, random_walk, rounding, parameters)
}

