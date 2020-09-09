

#--------------------------------------------------------------------------------------
# Data frames that store layer names, status of the layer (whether it is on), tile names
# and paths, and others. 
#--------------------------------------------------------------------------------------

df_pop <<- data.frame(id = c("lyr_pop_all", "lyr_pop_u5", "lyr_pop_women_repr"),
                      on = c(FALSE, FALSE, FALSE),
                      tile = c("tile_pop_all", "tile_pop_u5", "tile_pop_wrepr"),
                      tile_path = paste(fdir, "/", gsub(".tar.gz", "", df_files$fname[4:6]), sep = "")) 


df_lshd <<- data.frame(id = c("lyr_hamlet", "lyr_ssa", "lyr_settl", "lyr_bua", "lyr_bp"),
                       on = c(FALSE, FALSE, FALSE, FALSE, FALSE),
                       tile = c("tile_lshd_hamlet", "tile_lshd_ssa", "tile_lshd_settl", "tile_lshd_bua", NA),
                       clr = c("#91522d", "#10e0ff", "#1f78b4", "#984ea3", "000000"),
                       legend_label = c("Hamlet", "Small Settlement</br></br>Area", "Settlement", "Built-up Area", "Building Pattern"),
                       legend_id = c("lgnd_hamlet", "lgnd_ssa", "lgnd_settl", "lgnd_bua", "lgnd_bp"),
                       tile_path = c(paste(fdir, "/", gsub(".tar.gz", "", df_files$fname[c(8,10,9,7)]), sep = ""), NA))

df_lshd <<- df_lshd[1:4,]

df_bdry <<- data.frame(id = c("lyr_state", "lyr_lga", "lyr_wards"),
                       on = c(FALSE, FALSE, FALSE),
                       tile = c("tile_state", "tile_lga", "tile_wards"),
                       tile_path = paste(fdir, "/", gsub(".tar.gz", "", df_files$fname[c(2,1,3)]), sep = ""))

df_hfs <<- data.frame(id = c("cluster_hf", "cluster_hfgrid3", "cluster_school"),
                     on = c(FALSE, FALSE, FALSE),
                     data = c("hfr", "grid3","school"),
                     icon = c("medkit", "medkit","book"),
                     color = c("blue", "red","purple"))



#--------------------------------------------------------------------------------------
# Legend colors and labels defintion
#--------------------------------------------------------------------------------------
clr_pop <<- c('#ffff1e', "#ffc041", "#fcbba1", "#fb6a4a", "#ef3b2c", "#d1775e", "#cb181d", "#a50f15", "#67000d")
label_pop <<- c(0.2, 1, 2, 5, 10, 25, 50, 100, 275)



#--------------------------------------------------------------------------------------
# FUNCTIONS
#--------------------------------------------------------------------------------------

addLegendCustom <<- function(map, colors, labels, sizes, shapes, 
                             borders, opacity = 0.5, ...){
  
  make_shapes <- function(colors, sizes, borders, shapes) {
    shapes <- gsub("circle", "50%", shapes)
    shapes <- gsub("square", "0%", shapes)
    paste0(colors, "; width:", sizes, "px; height:", sizes, "px; border:1px solid ", 
           borders, "; border-radius:", shapes)
  }
  make_labels <- function(sizes, labels) {
    paste0("<div style='display: inline-block;height: ", 
           sizes, "px;margin-top: 0;line-height: ", 
           sizes, "px;'>", labels, "</div>")
  }
  
  legend_colors <- make_shapes(colors, sizes, borders, shapes)
  legend_labels <- make_labels(sizes, labels)
  
  return(addLegend(map, colors = legend_colors, labels = legend_labels, 
                   opacity = opacity, ...))
}



