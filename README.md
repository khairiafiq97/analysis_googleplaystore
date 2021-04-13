# analysis_googleplaystore

### How to get started 
1. Download R and an IDE for R such as RStudio 
2. Download the googleplaystore.csv file 
3. Run the code.R file in your RStudio 

### Intro of Dataset
The 'googleplaystore.csv' file has many different variables (such as Installs, Reviews etc) related to the different apps in the Google Play Store.

### Goals 
* To analyse how the different independent variables affect the response variable (I chose 'Installs' to be the response variable)
* To determine which is the biggest factor that affects the number of installs an application has. 

### Data Cleaning 
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

### 'Rating' variable (line code 89-95)
1. Using the boxplot rule, outliers were remmoved. 

### 'Size' variable (line code 99-110) 
1. log function was applied to the variable to make it more normally distributed. 
2. Using the boxplot rule, outliers were remmoved. 

