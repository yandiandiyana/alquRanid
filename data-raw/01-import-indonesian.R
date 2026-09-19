# Import Indonesian Qur'an translation
# Source: Tanzil Translation Repository
# File: id.indonesian.txt

raw <- readLines(
  "data-raw/id.indonesian.txt",
  encoding = "UTF-8"
)

# Keep only actual ayah records.
# Tanzil metadata lines begin with "#";
# blank lines are also excluded.
raw <- raw[
  grepl("^[0-9]+\\|[0-9]+\\|", raw)
]

# Split each line into:
# surat | ayat | teks_id
alquran_id <- read.delim(
  textConnection(raw),
  sep = "|",
  header = FALSE,
  stringsAsFactors = FALSE,
  quote = "",
  comment.char = ""
)

names(alquran_id) <- c(
  "surat",
  "ayat",
  "teks_id"
)

# Convert keys to integers
alquran_id$surat <- as.integer(alquran_id$surat)
alquran_id$ayat  <- as.integer(alquran_id$ayat)

# Validate
stopifnot(
  nrow(alquran_id) == 6236,
  all(!is.na(alquran_id$surat)),
  all(!is.na(alquran_id$ayat)),
  all(!is.na(alquran_id$teks_id)),
  all(alquran_id$surat >= 1),
  all(alquran_id$surat <= 114)
)

# Save package data
usethis::use_data(
  alquran_id,
  overwrite = TRUE
)
