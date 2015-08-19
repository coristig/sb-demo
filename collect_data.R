#collecting our data

nm <- read.csv("http://www.sgi.com/tech/mlc/db/churn.names", skip=4, colClasses=c("character", "NULL"), header=FALSE, sep=":")[[1]]

x <- 1
while(x < 5) {x <- x+1; 
  print("downloading latest datasets")
  Sys.sleep(1)
}
data <- read.csv("http://www.sgi.com/tech/mlc/db/churn.data", header=FALSE, col.names=c(nm, "Churn"))

#create our file name
date <- Sys.Date()
filename <- paste0('users-',date,'.csv')
write.table(data,filename,sep=',')

