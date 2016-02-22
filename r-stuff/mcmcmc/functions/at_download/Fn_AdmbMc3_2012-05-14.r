


#########################
#
# NOTES
# 1. This doesn't work if there are parameters that are fixed (because PAR and HST then disagree in the number of parameters)
#
#########################


#### Run 2-chain MC3 for ADMB from within R
# Heat=c(1;3); Ntot=10000; Nsweep=101; File; AdmbName; AdditionalAdmbArgs="-mcdiag"; Intern=FALSE
AdmbMc3 = function(Heat, Ntot, Nsweep, File, AdmbName, AdditionalAdmbArgs="", Intern=FALSE){

  Nfolders = 2
  FirstBurnIn = 10000

  Mcmc1 = Mcmc2 = numeric(0)
  Accept = rep(NA, Nsweep)

  Nmcmc = Ntot/(Nsweep-1)
  Nmcsave = min( 10, Nmcmc )

  # Loop through "sweeps" (i.e. each combinations of loops for all chains)
  for(SweepI in 1:Nsweep){

    print(paste("Sweep=",SweepI," Time=",date()," SwapAcceptRate=",mean(Accept,na.rm=TRUE),sep=""))
    Psv = Nll = vector("list",length=Nfolders)

    # Loop through "folders" (i.e. each separate chain)
    for(FolderI in 1:Nfolders){
      FolderFile = paste(File,"Folder_",FolderI,"\\",sep="")
      dir.create(FolderFile)

      # Make DAT file the first time for each chain
      if(SweepI==1){
        WriteDat(Loc=FolderFile, Heat=Heat[FolderI])
      }

      # Run and save MCMC sample
      file.copy(from=paste(File,AdmbName,".exe",sep=""), to=paste(FolderFile,AdmbName,".exe",sep=""), overwrite=FALSE)
      setwd(FolderFile)
      if(SweepI==1){
        # This seems to work okay
        shell(paste(AdmbName,".exe",sep=""), wait=TRUE, intern=Intern)   
        if(paste(AdmbName,".std",sep="") %in% list.files(FolderFile)){
          shell(paste(AdmbName," -mcmc ",FirstBurnIn," -mcsave ",FirstBurnIn-1," -noest -nohess -mcpin ",AdmbName,".par ",AdditionalAdmbArgs,sep=""), wait=TRUE, intern=Intern)             
        }else{
          shell(paste(AdmbName," -mcmc ",FirstBurnIn," -mcsave ",FirstBurnIn-1," -noest -nohess -mcpin ",AdmbName,".par -mcdiag",sep=""), wait=TRUE, intern=Intern)             
        }
        # This fails is hessian is not positive definite
        #shell(paste(AdmbName,".exe -mcmc ",FirstBurnIn," ",AdditionalAdmbArgs,sep=""), wait=TRUE, intern=Intern)             
      }
      if(SweepI>=2){
        if(paste(AdmbName,".std",sep="") %in% list.files(FolderFile)){
          shell(paste(AdmbName," -mcnoscale -mcr -noest -nohess -mcmc ",Nmcmc," -mcsave ",Nmcsave," ",AdditionalAdmbArgs,sep=""), wait=TRUE, intern=Intern)
        }else{
          shell(paste(AdmbName," -mcnoscale -mcr -noest -nohess -mcdiag -mcmc ",Nmcmc," -mcsave ",Nmcsave," ",AdditionalAdmbArgs,sep=""), wait=TRUE, intern=Intern)
        }
        if(FolderI==1) Mcmc1 = rbind(Mcmc1, ReadPsv(fn=paste(FolderFile,AdmbName,".psv",sep="")))
        if(FolderI==2) Mcmc2 = rbind(Mcmc2, ReadPsv(fn=paste(FolderFile,AdmbName,".psv",sep="")))
      }
      Psv[[FolderI]] = ReadPsv(fn=paste(FolderFile,AdmbName,".psv",sep=""))
      shell(paste(AdmbName," -mceval",sep=""), intern=TRUE) 
      Nll[[FolderI]] = read.csv(paste(FolderFile,"post.csv",sep=""))
      file.remove(paste(FolderFile,AdmbName,".psv",sep=""))   # Have to delete it every time, or the PSV file is corrupted
    }

    # Load PARs
      # Par is HST is not the same length as PAR for input to MCMC
    Par1 = Psv[[1]][nrow(Psv[[1]]),]
      #Par1_par = scan(paste(File,"Folder_1\\",AdmbName,".par",sep=""),comment.char="#",quiet=TRUE)
    Par2 = Psv[[2]][nrow(Psv[[2]]),]
      #Par2_par = scan(paste(File,"Folder_2\\",AdmbName,".par",sep=""),comment.char="#",quiet=TRUE)

    # Heat 1 Par 1
    Nll11 = Nll[[1]][nrow(Nll[[1]]),1]
    # Heat 2 Par 2
    Nll22 = Nll[[2]][nrow(Nll[[1]]),1]
    # Heat 2 Par 1
    Nll12 = Nll22*Heat[2]
    # Heat 1 Par 2
    Nll21 = Nll11/Heat[2]
    
    # Calculate odds ratio
    #P = exp(-Nll21)/exp(-Nll22) * exp(-Nll12)/exp(-Nll11) # Proposal ratio * Probability ratio
    P = exp(-1 * (Nll21 - Nll22 + Nll12 - Nll11) ) # Proposal ratio * Probability ratio
      print(paste("P=",P,sep=""))
      Accept[SweepI] = FALSE

    # Swap if P>1 or runif(1)<P
    if(P>1 || runif(1)<P){
      Accept[SweepI] = TRUE
      Hst1 = readLines(paste(File,"Folder_1\\",AdmbName,".hst",sep=""))
        Hst1[18] = paste(Par2,collapse=" ")
        writeLines(Hst1, con=paste(File,"Folder_1\\",AdmbName,".hst",sep=""))
      Hst2 = readLines(paste(File,"Folder_2\\",AdmbName,".hst",sep=""))
        Hst2[18] = paste(Par1,collapse=" ")
        writeLines(Hst2, con=paste(File,"Folder_2\\",AdmbName,".hst",sep=""))
    }
  }

  # Return results
  Return = list(Accept=Accept, Mcmc1=Mcmc1, Mcmc2=Mcmc2)
  return(Return)
}

### Read PSV binary file
ReadPsv = function(fn, nsamples=10000){
	# http://code.google.com/p/generic-crab-model/source/browse/trunk/GenericCrabModel/read.admb.r?spec=svn21&r=21
  #This function reads the binary output from ADMB
	#-mcsave command line option.
	#fn = paste(ifile,'.psv',sep='')
	filen <- file(fn, "rb")
	nopar <- readBin(filen, what = integer(), n = 1)
	mcmc <- readBin(filen, what = numeric(), n = nopar * nsamples)
	mcmc <- matrix(mcmc, byrow = TRUE, ncol = nopar)
	close(filen)
	return(mcmc)
}

