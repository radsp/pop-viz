#----------------------------------------------------------------------
# Retrieve and save map tiles
#----------------------------------------------------------------------

# File ID of table that store the zipped tile files
f_id <- 116305434
df_files <- read_civis(f_id, using = readr::read_csv)



# # # Directory to save downloaded and unpacked files
fdir <- "../data_unpacked"
if(!dir.exists(fdir)) {dir.create(fdir)}


# Unpack and store tiles in the fdir folder
for (i in 1:nrow(df_files)) {
  download_civis(df_files$id[i],
                 file = paste(fdir, "/",df_files$fname[i], sep = ""),
                 overwrite = TRUE)
  untar(paste(fdir, "/", df_files$fname[i], sep = ""), exdir = fdir)
}




hfr <- read_civis(119911207)
grid3 <- read_civis(119911927)
school <- read_civis(119910521)