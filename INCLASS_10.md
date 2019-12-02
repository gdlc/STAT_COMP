

Goals:

  - To fit a mixture model to hourly wages
  - To cluster subjects using a mixture model according to their wages
  - And to examine the association between the clusters and education, sex and race.
 
 (1) Use the [wages](https://github.com/gdlc/STAT_COMP/blob/master/wages.txt) data set to fit a mixture models with 2, 3 and 5 components.
     Plot in one graph the three fitted mixtures. Add one more line with a non-parameteric dessity fit (`tmp<-density(z)` fits a density to variable `z`,  `tmp$x` and `tmp$y` will give you the x-y coordinates for a density plot, try `lines(x=tmp$x,y=tmp$y` to add lines to an exisiting plot).
     
  (2) Report proportion of male, average years of education and proportions of whites in each of the clusters, for each of the mixtures.
  
  
