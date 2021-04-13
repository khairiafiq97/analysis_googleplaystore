google = read.csv("googleplaystore.csv")

google = subset(google, select = -c(Price, Last.Updated, Genres, Current.Ver, Content.Rating))
summary(google)
summary(google$Rating)
summary(google$Installs)
summary(google$Category)

summary(google$Reviews)
summary(google$Size)
summary(google$Android.Ver)
summary(google$Type)

library("stringr")

#	Remove unwanted values in Type column 
google = subset(google, google$Type != "0") 
google = subset(google, google$Type != "NaN")

#	Remove unwanted values in Android.Ver column 
google = subset(google, google$Android.Ver != "") 
google = subset(google, google$Android.Ver != "NaN")
google = subset(google, google$Android.Ver != "Varies with device")

#	Changing the "Reviews" column from categorical factor to numeric 
google$Reviews = as.numeric(paste(google$Reviews))

#	Removing rows where column 3 (Rating) has 'na'

google = google[complete.cases(google[, 3]),]

#Remove "+" and "," from "Installs" column so that we can convert into numeric variable 
google$Installs = gsub("\\+", "", google$Installs) 
google$Installs = gsub("\\,", "", google$Installs)

google$Installs = as.numeric(paste(google$Installs))

# Remove "Varies with Device" from "Size" column

google = subset(google, google$Size != "Varies with device") ##"size" includes both MB and KB storage

for (i in (1:length(google$Size))) {
  if (str_detect(google$Size[i],"k")) {
    google$y[i]="k"
  }
  
  else if (str_detect(google$Size[i],"M")){
    google$y[i]="M"
  }
}

google$Size= gsub("\\M", "", google$Size) 
google$Size= gsub("\\k", "", google$Size) 
google$Size=as.numeric(paste(google$Size)) 
for (i in (1:length(google$Size))) {
  if (google$y[i]=="k"){
    google$Size[i]=google$Size[i]/1000
  }
}

##	to remove that last variable "y" 
google = subset(google, select = -9)


# Histogram and Boxplot of Installs
hist(google$Installs, main= "Histogram of Installs")
hist(log(google$Installs), main= "Histogram of ln(Installs)")
boxplot(log(google$Installs),main="Boxplot of ln(Installs)")

quantile(log(google$Installs),0.25)-1.5*IQR(log(google$Installs))
hist(log(google$Installs[log(google$Installs) >=2.3025851 ]), breaks=10, main =
       "Histogram of (ln(Installs) >= 2.3025851)")
boxplot(log(google$Installs[log(google$Installs) >=2.3025851 ]),main="Boxplot of
(ln(Installs) >= 2.3025851)")
google = subset(google, log(google$Installs) >=2.3025851)

summary(log(google$Installs))


# Histogram and Boxplot of Reviews
hist(google$Reviews, main = "Histogram of Reviews")

hist(log(google$Reviews), main = "Histogram of ln(Reviews)")
boxplot(log(google$Reviews),main="Boxplot of ln(Reviews)")


# Histogram and Boxplot of Rating

hist(google$Rating, main = "Histogram of Rating")
boxplot(google$Rating, main="Boxplot of Rating")
quantile(google$Rating,0.25)-1.5*IQR(google$Rating)
hist(google$Rating[google$Rating >=3.25], main = "Histogram of (Rating >= 3.25)")
boxplot(google$Rating[google$Rating >=3.25],main="Boxplot of (Rating >= 3.25)")

google = subset(google, google$Rating>= 3.25)


# Histogram and Boxplot of Size
hist(google$Size, main = "Histogram of Size")

hist(log(google$Size),main = "Histogram of ln(Size)")
boxplot(log(google$Size),main="Boxplot of ln(Size)")
quantile(log(google$Size),0.25)- 1.5*IQR(log(google$Size))



hist(log(google$Size[log(google$Size) >=-1.073543 ]), main = "Histogram of (ln(Size)) >= -1.073543")

boxplot(log(google$Size[log(google$Size) >=-1.073543 ]), main = "Boxplot of (ln(Size)) >= -1.073543")
google = subset(google, log(google$Size) >= -1.073543)

#	Barchart for Category 
category=table(google$Category) 
category 
CATEGORY=category[names(category)!="1.9"]
barplot(CATEGORY,las=1, cex.names=.4,horiz=T, main = "No. of apps in each Category")

#	Barchart for Type
type = table(google$Type)
type
TYPE=type[(type!=0)&(type!="NaN")]
barplot(TYPE, main = "No. of apps in each Type")

# Barchart for Android.Ver
android = table(google$Android.Ver)
android
ANDROID=android[(names(android)!="")&(names(android)!="2.2 - 7.1.1")&(names(android)!="5.0 - 7.1.1")&(names(android)!="NaN")&(names(android)!="Varies with device")]
barplot(ANDROID, las=1, cex.names = 0.4, horiz=T, main = "No. of apps in each Android.Ver")

#	Relation between log(Installs) and log(Reviews) 
slr=lm(log(Installs)~log(Reviews),data=google) 
summary(slr)
cor.test(log(google$Installs), log(google$Reviews))

plot(log(google$Reviews),log(google$Installs),xlab="log(Reviews)",ylab="log(Installs)") 
abline(slr,col="red")

#	Relation between log(Installs) and log(Size)
slr=lm(log(Installs)~log(Size), data=google)
summary(slr)
cor.test(log(google$Installs), log(google$Size))

plot(log(google$Size),log(google$Installs),xlab="log(Size)",ylab="log(Installs)")
abline(slr,col="red")

#	Relation between log(Installs) and Rating 
slr=lm(log(Installs)~Rating,data=google) 
summary(slr)
plot(google$Rating,log(google$Installs),xlab="Rating",ylab="log(Installs)")
abline(slr,col="red")

cor.test(google$Rating, log(google$Installs))



# Relation between log(Installs) and Type
boxplot(log(google$Installs)~(google$Type) ,main="Number of Installs based on Type of App",axes=F)
var.test(log(google$Installs)[google$Type=='Free'],log(google$Installs)[google$Type=='Paid'])
t.test(log(google$Installs)[google$Type=='Free'],log(google$Installs)[google$Type=='Paid'
                                                                      ],alternative='greater',var.equal = FALSE)

#	single factor that is more important in affecting the number of Installs than others 
slr1 = lm(log(google$Installs)~log(google$Reviews))
summary(slr1) 
qqnorm(slr1$residuals) 
qqline(slr1$residuals,col='blue')

slr2 = lm(log(google$Installs)~log(google$Size)) 
summary(slr2)
qqnorm(slr2$residuals) 
qqline(slr2$residuals,col='blue')

slr3 = lm(log(google$Installs)~google$Rating) 
summary(slr3)
qqnorm(slr3$residuals) 
qqline(slr3$residuals,col='blue')

#	Correlations between Continuous Variables

google$Reviews=log(google$Reviews)
google$Installs=log(google$Installs)
google$Size=log(google$Size)

names(google) = c("App","Category","Rating","log(Reviews)","log(Size)","log(Installs)","Type","Android.Ver")

panel.cor <- function(x, y){
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  
  r <- round(cor(x, y), 2)
  text(0.5, 0.5, paste("R = ",r))
}
plot(google[,3:6], panel=panel.smooth,lower.panel=panel.cor)
