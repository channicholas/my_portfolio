# November 3rd

# Matrices 
#Differences between matrices and data frame, matrix must have all the same data types, some math things must have matrices
# Creating a Matrix
A = matrix(1:9, nrow = 3, ncol = 3)#it fills in first by column then by row
A 

A = matrix(1:9,nrow=3,ncol=3,byrow=TRUE)#it fills in first by row then by column
A

A=matrix(1:9,nrow=3)
A
A = matrix(1:10, nrow=3) #does same thing as a vector when trying to populate it with more numebrs then rows/columns
A


library(tidyverse)
df=tibble("num1" = 1:3,
          "num2" = rep(4,3),
          "num3" = c(16,11,15))
df
B = as.matrix(df)
B

df=tibble("num1" = 1:3,
          "num2" = rep(4,3),
          "num3" = c("a","b","c"))
B = as.matrix(df) #makes a matrix but everything is then just characters, you can't have two different types of data
B 
# Subsets
A[1,] #This prints first row
A[,1] #This prints first column
A[2,3] # this prints the number on row 2, column 3
A[1,1] = 17 #changes number at that coordinate
A[1,1]
A[,3] = c(3,2,9)
A[,3]
A

A=matrix(1:9,nrow=3)
df=tibble("num1" = 1:3,
          "num2" = rep(4,3),
          "num3" = c(16,11,15))
B = as.matrix(df)

# Matrix Maths
A+B
A*B

# PROPER MATRIX MULTIPLICATION
A %*% B #Multiplies A and B
A[,3] = c(3,2,9)
solve(A) %*% A #A inverse times B
solve(A,A) #Does the same thing as above

det(A) #determinate (whatever that is)

eigen(A)

A_byrow = matrix(1:9,ncol=3,byrow=TRUE)
A_bcol = matrix(1:9, ncol=3)
A_bcol
A_byrow
t(A_byrow) #switches rows and columns
A[,c(2,3,1)] #switches columns


# colSums, rowSums, apply
colSums(A) # takes the columns and sums them

rowSums(A) #takes the rows and sums them

apply(A,1, sum)#this takes a matrix, then a direction then takes a function, 
# default direction is rows (1 is rows and 2 is columns) sum is the thing we are applying
apply(A,2,sum)

apply(A,1,sd)#applys standard deviations

apply(A,2,max)
mean(A)


# November 5th

# Mini Tasks
# Make a 7 by 3 matrix of all 10's
mat = matrix(10,nrow=7, ncol = 3)
mat

# Use dim() to find the dimension
dim(mat)

# Change the first column to be 1 vector 1:7
mat[,1] <- c(1:7)
mat

# find the transpose and the dimension of the transpose
mat_t <- t(mat) ### TRANSPOSE
mat_t 
dim(mat_t)
# Find the mean of each column using apply
apply(mat,2,mean)








