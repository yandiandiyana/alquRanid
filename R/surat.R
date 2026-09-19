#' Ambil satu surat dari Al-Qur'an
#'
#' Mengembalikan seluruh ayat dari surat yang dipilih,
#' beserta teks Arab dan terjemahan Bahasa Indonesia.
#'
#' @param nomor Nomor surat, dari 1 sampai 114.
#'
#' @return Data frame berisi nomor surat, nomor ayat,
#'   teks Arab, dan terjemahan Indonesia.
#'
#' @examples
#' surat(1)
#' surat(2)
#' surat(114)
#'
#' @export
surat <- function(nomor) {

  # Validasi tipe
  if (!is.numeric(nomor) || length(nomor) != 1 || is.na(nomor)) {
    stop("nomor harus berupa satu angka.")
  }

  # Validasi bilangan bulat
  if (nomor != as.integer(nomor)) {
    stop("nomor surat harus berupa bilangan bulat.")
  }

  # Validasi rentang
  if (nomor < 1 || nomor > 114) {
    stop("nomor surat harus antara 1 dan 114.")
  }

  # Ambil surat
  hasil <- alquran[alquran$surat == nomor, , drop = FALSE]

  # Reset row names
  rownames(hasil) <- NULL

  hasil
}
