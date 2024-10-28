# plot acc line 
plot_accline = function(trainaacc, testacc, tree, title){
  
  plot(c(1:tree), trainaacc, type = "b", frame = FALSE, pch = 18, col='blue',
       xlab = title, ylab = "accuracy", ylim = c(min(testacc),max(c(testacc,max(trainaacc))))
  )
  lines(c(1:tree), testacc, pch = 19, col = "red", type = "b", 
        lty = 2, lwd = 1)
  legend("topleft", legend = c("train", "test"),
         col = c("blue", "red"), lty = 1:2, cex = 0.5)
}