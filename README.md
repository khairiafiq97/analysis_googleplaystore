# analysis_googleplaystore

## How to get started 
1. Download R and an IDE for R such as RStudio 
2. Download the googleplaystore.csv file 
3. Run the code.R file in your RStudio 

## Intro of Dataset
The 'googleplaystore.csv' file has many different variables (such as Installs, Reviews etc) related to the different apps in the Google Play Store.

## Goals 
* To analyse how the different independent variables affect the response variable (I chose 'Installs' to be the response variable)
* To determine which is the biggest factor that affects the number of installs an application has. 

## Data Cleaning 
1. 'Type' variable: Values '0' and 'NaN' was removed because they are not applicable. I am only focusing on 'Paid' and 'Free' app categories
2. 'Android.Ver' variable: Values 'NaN' and 'Varies with Device' was removed. 
3. 'Reviews' variable: Change the values from categorical to numerical because they are more suitable as numerical variables
4. 'Rating' vairable: Values 'na' were removed 
5. 'Installs' variable: Remove '+' and '-' in the values as well as changing to numerical variables 
6. 'Size' variable: Converting values in 'kB' into 'MB' values (for standardization) and then removing 'k' and 'M' 
7. 'App' variable: NIL 
8. 'Category' variable: NIL 

## Removing outliers 

### 'Installs' variable (line code 66-77)
1. log function was applied to the variable to make it more normally distributed. 
2. Using the boxplot rule, outliers were remmoved. 

*Before and After*

![Rplot46](https://user-images.githubusercontent.com/81233513/114515006-79e02380-9c6e-11eb-8b59-84dfca9d366b.png)

### 'Reviews' variable (line code 81-84) 
1. log function was applied to the variable to make it more normally distributed. 

*Before and After*

![Rplot47](https://user-images.githubusercontent.com/81233513/114515683-32a66280-9c6f-11eb-81e7-e48a3ebb751e.png)

### 'Rating' variable (line code 89-95)
1. Using the boxplot rule, outliers were remmoved. 

*Before and After*

![Rplot48](https://user-images.githubusercontent.com/81233513/114515687-33d78f80-9c6f-11eb-98ed-f3fe74dc6e8c.png)

### 'Size' variable (line code 99-110) 
1. log function was applied to the variable to make it more normally distributed. 
2. Using the boxplot rule, outliers were remmoved. 

*Before and After*

![Rplot49](https://user-images.githubusercontent.com/81233513/114515690-33d78f80-9c6f-11eb-9dc4-017f9dfdd4b7.png)

## Relationship Between log(Installs) and the Dependent Variables 

### Relationship between log(Installs) and Type (line code 155-159)
* There are 2 categories for 'Type' variable: 'Free' and 'Paid'
* From the boxplot, we can tell that the 'Free' apps has a greater mean log(Installs) value than the 'Paid' apps 
* A variance test is conducted first to test whether the 2 variance are equal or not. Since p-value (<2.2e-16) is smaller than alpha, the 2 variances are not equal. 
* Next, a t-test is conducted to determine whether the true mean log(Installs) value of 'Free' apps is truly greater than 'Paid' apps. Since p-value (<2.2e-16) is smaller than alpha, the alternate hypothesis is true. 
* Thus, we can conclude that 'Free' apps produces greater number of Installs than 'Paid' apps 

### Relationship between log(Installs) and log(Reviews) 
* A linear regression model is built (where log(Installs) is the y-axis and log(Reviews) is the x-axis) 
* p-value<2.2e-16
* R-squared = 0.9108
* Pearson correlation co-efficient = 0.9543838

*Residual QQ-plot (we can tell that it is approximately normal distributed which is good)*

![Rplot50](https://user-images.githubusercontent.com/81233513/114528779-e281cd00-9c7b-11eb-89d2-e2ec44865951.png)

### Relationship between log(Installs) and log(Size) 
* A linear regression model is built (where log(Installs) is the y-axis and log(Size) is the x-axis) 
* p-value<2.2e-16
* R-squared = 0.1156 
* Pearson correlation co-efficient = 0.3399686

*Residual QQ-plot (we can tell that it is approximately normal distributed which is good)*

![Rplot51](https://user-images.githubusercontent.com/81233513/114529389-7a7fb680-9c7c-11eb-9441-51a770cccdf2.png)

### Relationship between log(Installs) and Rating 
* A linear regression model is built (where log(Installs) is the y-axis and Rating is the x-axis) 
* p-value = 4.94e-14
* R-squared = 0.007374
* Pearson correlation co-efficient = 0.0858695 

*Residual QQ-plot (we can tell that it is approximately normal distributed which is good)*


