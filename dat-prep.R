myid <- 115449415

fdir <- "data_unpacked"
if(!dir.exists(fdir)) {dir.create(fdir)}

download_civis(myid, file = paste(fdir, "/all.tar.gz", sep = ""), overwrite = TRUE)
untar(paste(fdir, "/all.tar.gz", sep = ""), exdir = fdir)
