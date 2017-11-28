**Short answer**: The results of the two approaches (linear versus non-linear model) do not match because the relationship between body mass and basal metabolic rate does not strictly follow a power law.

----------

It is indeed the case that if the relationship between two variables follows a power law the two approaches should provide comparable results, but important differences could arise due to [Jensen's inequality][1]. In order to test whether the reported differences between the two approaches are due to Jensen's inequality or to some biological factor I obtained data from [Kolokotrones et al. (2010)][2] who have in turn taken them from [McNab (2008)][3]. [Kolokotrones et al. (2010)][2] investigated the issue of whether a power law is appropriate by performing linear regression on log-transformed data but they did not attempt to fit the data with non-linear regression.

I've fitted a non-linear model of the form:
$$ B = \alpha M^{b} $$
, where $M$ the body mass (in grams) and $B$ the basal metabolic rate (in Watts),
which gave coefficients $\alpha = 0.005$ and $b = 0.87$.
I also fitted a linear model of the form:
$$ log_{10}(B) = blog_{10}(M) + log_{10}(\alpha) $$

which gave coefficients $\alpha = -1.7$ and $b = 0.72$.

It appears that the results of the two approaches are indeed different. Below I plot the results of the two fits. On the variables' original scale we see that the linear model fails to predict observations from species with large mass and that the non-linear model does much better in this respect (upper left). However, when we look at the two models after log-transform, it is clear that the non-linear model fails to predict many observations from species with low mass (upper right). Looking at the residuals of the non-linear model we see that the errors are multiplicative as the variance of the residuals is increasing with (log-transformed) fitted values (bottom left). This indicates that fitting with a linear model on log-transformed data is warranted. However, the plot of linear model's residuals over log-transformed fitted values (bottom right) confirms that the linearity assumption is violated. Thus, neither method is appropriate for this dataset and the quadratic term the authors of the cited paper added in the linear model fitted on the log-transformed variables appears to be warranted in order to account for the observed convexity.

[![enter image description here][4]][4]

We can conclude that for this dataset the results of the linear model approach do not match those of the non-linear model approach because *the data do not strictly follow a power law*. Rather, the megafauna appears to follow a different trend compared to smaller animals. [Kolokotrones et al. (2010)][2] found that additionally adjusting for temperature improved the linear fit, in addition to the inclusion of the quadratic term. The resulting model was:

$$ log_{10}B = \beta_0 + \beta_1log_{10}M + \beta_2(log_{10}M)^2 + \frac{\beta_T}{T} + \epsilon $$
<br> <br>
The R code used to generate the results for this answer along with the data used can be found in the following git repository in GitLab:
https://gitlab.com/vkehayas-public/metabolic_scaling

<sub> **References**
Kolokotrones, T., Van Savage, Deeds, E. J., & Fontana, W. (2010).
Curvature in metabolic scaling. *Nature*, **464**:7289, 753–756. [https://doi.org/10.1038/nature08920][2]
McNab, B.K. (2008). An analysis of the factors that influence the level and scaling of mammalian BMR. *Comparative Biochemistry and Physiology Part A: Molecular & Integrative Physiology*, **151**:1, 5-28. [https://doi.org/10.1016/j.cbpa.2008.05.008][3].
</sub>

[1]: https://stats.stackexchange.com/a/58077/97671
[2]: https://www.nature.com/nature/journal/v464/n7289/full/nature08920.html
[3]: http://www.sciencedirect.com/science/article/pii/S1095643308007782
[4]: https://i.stack.imgur.com/LGbf5.png
