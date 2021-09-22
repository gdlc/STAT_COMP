### Gauss-Seidel (GS)

This iteratrive algorithm can be used to solve systems of equations that are diagonal dominant [1]. 

Consider a system of equations of the form:  

   **Cb=r**
   
 Where, **C** (the matrix of coefficients) is a pxp matrix with known entries, **r** is a pxq (often q=1) array with known entries, aka the *right-hand-side*, and **b** is a pxq array of uknowns. We will focus in the case where q=1.
 
 The OLS equations are a special case of the above with **C=X'X** and **r=X'y**.
 
 The step of the GS are as follows:
 
   (0) Intitialize **b** (e.g., **b=0**, we will discuss better ways of initializing).
   (1) for i in 1:p update the entries of **b** using  `b[i]=(r[i]-sum(C[i,-i]*b[i]))/C[i,i]`. In esscence what we are doing here is to treat all the entries of **b**, except the ith entry as known. Then we look at the pth equation of the system `sum(C[i,]*b)=r[i]` and note that the left-hand-side can be written as `sum(C[i,-1]*b[-i])+b[i]*C[i,i]`, thus, we write the pth-equation as `sum(C[i,-1]*b[-i])+b[i]*C[i,i]=r[i]`. Solving for `b[i]` yields the update used in this step.
   (2) Repeat (1) until convergence.
