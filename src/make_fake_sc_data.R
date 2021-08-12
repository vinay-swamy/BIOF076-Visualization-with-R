library(tidyverse)
data <- read_tsv('src/pbmc_cell_expression.tsv.gz')
keep_side <- data[,c(1:3, 5:6)]
pid_resample <- tibble(patient_id = sample(data$patient_id, size = nrow(data), replace = T))
gexp_resample <- lapply(5:14, function(x) rlnorm(nrow(data), sdlog = sample(1:10, 1)) ) %>% do.call(cbind, .) %>% as.data.frame
colnames(gexp_resample) <- colnames(data)[-(1:6)] 
res <- bind_cols(keep_side, pid_resample, gexp_resample)
write_tsv(res, paste0( 'sc_data_', paste0(sample(LETTERS,size = 5, replace = T ), collapse = ''), '.tsv' ))
          
          