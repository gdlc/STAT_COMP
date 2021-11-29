### In-class assigment 19

Section 1 of the [handout](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/HIGH_DIMENSIONAL_REGRESSIONS.pdf) on high-dimensional regressions build prediction models
using least-square regressions that use the top-q markers. Figure 2 displays, for one training-testing partition, the correlation between phenotypes and predictions in the testing set
by *q* (i.e., the number of markers in the model). The estimated curve is subject to sampling variability. 

The task of this assigment is to produce 10 curves such as the blue one displaied in Figure 2, each produced with a different training-testing parititon.


Hints:
   - Be sure you can run the code needed to produce Figure 2 (code is reproduced below for your convinience).
   - To run your code faster, you may consider going up to 200 markers only (currently it goes up to 300)
   - Create an object `COR` with 200 rows (the maximum DF) and 10 columns (the 10 TRN-TST partitions).
   - You will use this object to store in columns 10 curves such as the blue one in Figure 2, each produced with a different TRN-TST partition.
   - Embed the code that was used to produce figure 2 into a loop from (*h* in 1:100), each time generating a new partition, and storing the prediction
   curve (`corTST` in the example) into the hth column of COR, that is `COR[,h]=corTST`.
   - Once you finsih, you can calculate an average curve using `rowMeans(COR)`.
   - To display all the curves, initialize a plot with `xlim=c(0,200)` and `ylim=range(COR)`,
   - Using a loop, add lines to the plot `lines(x=1:200,y=COR[,i],lwd=.5,col=4)`
   - Finally, add the average curve using `lines()`.
   
 You can get the script used to produce Figure 2 of the handout [here](https://github.com/gdlc/STAT_COMP/blob/master/HANDOUTS/HIGH_DIMENSIONAL_REGRESSIONS.Rmd).
