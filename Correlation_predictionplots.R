R <- c()
for (i in 1:dim(pair)[2]) {
 R <- c(R,cor(pair[i,2], pair[i,4]))
}

e <- c()
rel <- c()
df <- c()
for(i in seq(0, 1.2, by = 0.01)) { 
  x <- pair[which(pair$REL < (i+0.01) & pair$REL > i),]
  a <- cor.test(x$FEV1.FVC2, x$MFEV1.FVC2)
  rel <- c(rel, i)
  e <- c(e, a$estimate)
  d <- x$FEV1.FVC2-x$MFEV1.FVC2
  new <- cbind(d,i)
  df <- rbind(df, new)
}
names(e) <- rel

e <- c()
rel <- c()
for(i in seq(2, 8, by = 1)) { 
  x <- sibs[which(sibs$totalrelatives ==i),]
  a <- cor.test(x$Pred, x$Obs)
  rel <- c(rel, i)
  e <- c(e, a$estimate)
}
names(e) <- rel