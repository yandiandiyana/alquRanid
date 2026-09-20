#' Memecah ayat berdasarkan tanda waqaf
#'
#' Fungsi internal untuk memecah teks ayat berdasarkan tanda
#' waqaf yang terdapat dalam teks Al-Qur'an.
#'
#' @param teks Teks Arab ayat.
#'
#' @return Vektor karakter berisi bagian-bagian ayat.
#' @noRd
pecah_bagian <- function(teks) {

  tanda_waqaf <- c(
    "ۚ", "ۖ", "ۗ", "ۙ", "ۘ", "ۛ", "ۜ"
  )

  for (tanda in tanda_waqaf) {
    teks <- gsub(tanda, "|", teks, fixed = TRUE)
  }

  bagian <- strsplit(teks, "|", fixed = TRUE)[[1]]

  bagian <- trimws(bagian)

  bagian[bagian != ""]
}
