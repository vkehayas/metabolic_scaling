library(ggplot2)

# Import data
dt = read.csv("Kolokotrones et al.csv")
df = data.frame(x = dt$Mass..g., y = dt$BMR..W.)

# Fit with non-linear least-squares regression
nlm = nls(y~a*x^b, start = list(a=0.005,b=0.75), data = df)
yN = predict(nlm, x = c(min(df$x, na.rm = TRUE), max(df$x, na.rm = TRUE)))
res_nlm = residuals(nlm)
ggplot() + geom_histogram(aes(res_nlm), bins = 100) + xlab("residuals")
ggplot() + geom_point(aes(x = df$x, y = df$y)) + geom_line(aes(x = x, y = yN), data = df) +
  xlab("Mass \n (grams)") +
  ylab("BMR \n (W)")

# Fit log-transformed data with linear model
logdf = data.frame(x = log10(df$x), y = log10(df$y))
lm1  = lm(y ~ 1 + x, data = logdf)
ggplot() + geom_histogram(aes(lm1$residuals), bins = 100) + xlab("residuals")
ggplot() + 
  geom_point(aes(x = logdf$x, y = logdf$y)) + 
  geom_line(aes(x = logdf$x, y = lm1$fitted.values)) +
  xlab("Mass \n (log10-grams)") +
  ylab("BMR \n (log10-W)")

# Plot data on original scale
ggplot() + 
  geom_point(aes(x = df$x, y = df$y)) + 
  geom_line(aes(x = x, y = yN, colour = "Non-Linear"), data = df) + 
  geom_line(aes(x = 10^(logdf$x), y = 10^(lm1$fitted.values), colour = "Linear")) +
  scale_colour_manual("",values = c("black", "red")) +
  xlab("Mass \n (grams)") +
  ylab("BMR \n (W)")

# Plot log-tranformed data
ggplot() + 
  geom_point(aes(x = logdf$x, y = logdf$y)) + 
  geom_line(aes(x = logdf$x, y = log10(yN), colour = "Non-Linear"), data = df) + 
  geom_line(aes(x = logdf$x, y = lm1$fitted.values, colour = "Linear")) +
  scale_colour_manual("",values = c("black", "red")) +
  xlab("Mass \n (log-grams)") +
  ylab("BMR \n (log-W)")

# Plot diagnostics
plot(lm1, which = 1)

hist(log10(df$x),xlab = "Mass \n (log10-grams)", main = "")
hist(log10(df$y),xlab = "BMR \n (log10-W)", main = "")

fNLM = fitted(nlm)
plot(fNLM, res_NLM)


