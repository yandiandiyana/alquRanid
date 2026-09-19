#' Cari kata atau frasa dalam terjemahan Al-Qur'an
#'
#' Mencari kata atau frasa dalam terjemahan Al-Qur'an
#' Bahasa Indonesia.
#'
#' @param kata Kata atau frasa yang ingin dicari.
#'
#' @return Data frame berisi surat, ayat, dan terjemahan
#'   yang mengandung kata atau frasa tersebut.
#'
#' @examples
#' cari("Allah")
#' cari("rahmat")
#' cari("orang-orang")
#'
#' @export
cari <- function(kata) {

  # Validasi input
  if (!is.character(kata) || length(kata) != 1 || is.na(kata)) {
    stop("kata harus berupa satu teks.")
  }

  # Tolak string kosong
  if (trimws(kata) == "") {
    stop("kata tidak boleh kosong.")
  }

  # Cari teks secara literal dan tidak sensitif terhadap huruf besar/kecil
  kata_regex <- paste0(
    "\\Q",
    kata,
    "\\E"
  )

  cocok <- grepl(
    kata_regex,
    alquran_id$teks_id,
    ignore.case = TRUE,
    perl = TRUE
  )

  hasil <- alquran[cocok, , drop = FALSE]

  # Reset row names
  rownames(hasil) <- NULL

  hasil
}
