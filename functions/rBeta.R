

# Create a Beta Distribution function (used in PPP-Uncertainty.Rmd for Benefit and Success/Feasability)
rBeta <- function (n, mu, sigmasq) # mu = mean. sigmasq = variance
{
    if (mu <= 0 || mu >= 1) stop("Mean is outside the range for a beta distribution.")
    if (sigmasq <= 0 || sigmasq >= 0.25) stop("Variance is outside the range for a beta distribution.")
    if (sigmasq <= 0 || sigmasq >= 0.084) stop("Variance is causes distribution to flip to a U shape with no mode.")
    alpha <- ((1-mu)/sigmasq - (1/mu))*mu^2
    beta <- (sigmasq + mu^2 - mu)*(mu - 1)/sigmasq
    rbeta(n, shape1=alpha, shape2=beta)
}