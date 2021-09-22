### Gauss-Seidel (GS)

This iteratrive algorithm can be used to solve systems of equations that are diagonal dominant [1]. 

Consider a system of equations of the form:  

   **Cb=r**
   
 Where, **C** (the matrix of coefficients) is a pxp matrix with known entries, **r** is a pxq (often q=1) array with known entries, aka the *right-hand-side*, and **b** is a pxq array of uknowns. We will focus in the case where q=1.
 
 The OLS equations are a special case of the above with **C=X'X** and **r=X'y**.
 
 The step of the GS are as follows:
 
   - (0) Intitialize **b** (e.g., **b=0**, we will discuss better ways of initializing).
   - (1) for loop `for(i in 1:p)` update the entries of **b** using  `b[i]=(r[i]-sum(C[i,-i]*b[-i]))/C[i,i]`.  
   - To understand why we use this update, note that the ith-equation of the system is
       - `sum(C[i,]*b)=r[i]` 
       - We can write this as `sum(C[i,-i]*b[-i])+b[i]*C[i,i]=r[i]`. 
       - At the ith iteration of the loop, we treat all but the ith entry of **b** as known, solving for `b[i]` yields `b[i]=(r[i]-sum(C[i,-i]*b[-i]))/C[i,i]`.
   - (2) Repeat (1) until convergence.


[1]: A diagonal dominant matrix satisfies `C[i,i]>=sum(abs(C[i,-i]))` for i=1,...,p. The algorithm is guaranteed to converge only for diagonal dominant matrices. 
