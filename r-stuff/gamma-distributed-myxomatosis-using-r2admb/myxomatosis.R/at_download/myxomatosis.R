library(R2admb)
library(emdbook)
setup_admb()

data(MyxoTiter_sum)
myxdat=subset(MyxoTiter_sum, grade==1)

write_dat("myxomatosis", L=list(nobs=nrow(myxdat), titer=myxdat$titer, day=myxdat$day))
write_pin("myxomatosis", L=list(a=1, b=0.2, s=50))
compile_admb("myxomatosis", verbose=TRUE)
run_admb("myxomatosis", verbose=TRUE)

myxo1_admb=read_admb("myxomatosis")
summary(myxo1_admb)

clean_admb("myxomatosis")