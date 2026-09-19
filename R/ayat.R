#' Ambil satu ayat dari Al-Qur'an
#'
#' Mengembalikan satu ayat berdasarkan nomor surat dan nomor ayat.
#'
#' @param nomor_surat Nomor surat, dari 1 sampai 114.
#' @param nomor_ayat Nomor ayat, berupa satu angka atau beberapa angka.
#'
#' @return Data frame dengan satu baris berisi nomor surat,
#'   nomor ayat, dan terjemahan Indonesia.
#'
#' @examples
#' ayat(1, 1)
#' ayat(2, 255)
#' ayat(114, 1:3)
#' ayat(2, c(255, 256))
#'
#' @export
ayat <- function(nomor_surat, nomor_ayat) {

  # Validasi nomor surat
  if (!is.numeric(nomor_surat) ||
      length(nomor_surat) != 1 ||
      is.na(nomor_surat)) {
    stop("nomor_surat harus berupa satu angka.")
  }

  if (nomor_surat != as.integer(nomor_surat)) {
    stop("nomor_surat harus berupa bilangan bulat.")
  }

  if (nomor_surat < 1 || nomor_surat > 114) {
    stop("nomor_surat harus antara 1 dan 114.")
  }

  # Validasi nomor ayat
  if (!is.numeric(nomor_ayat) ||
      length(nomor_ayat) < 1 ||
      any(is.na(nomor_ayat))) {
    stop("nomor_ayat harus berupa angka.")
  }

  if (any(nomor_ayat != as.integer(nomor_ayat))) {
    stop("nomor_ayat harus berupa bilangan bulat.")
  }

  if (any(nomor_ayat < 1)) {
    stop("nomor_ayat harus berupa bilangan positif.")
  }

  # Ambil ayat
  hasil <- alquran[
    alquran$surat == nomor_surat &
      alquran$ayat %in% nomor_ayat,
    ,
    drop = FALSE
  ]

  # Ayat tidak ditemukan
  if (nrow(hasil) == 0) {
    stop(
      sprintf(
        "Ayat %s tidak ditemukan dalam surat %s.",
        paste(nomor_ayat, collapse = ", "),
        nomor_surat
      )
    )
  }

  # Pastikan semua ayat yang diminta ditemukan
  ayat_tidak_ditemukan <- setdiff(
    nomor_ayat,
    hasil$ayat
  )

  if (length(ayat_tidak_ditemukan) > 0) {
    stop(
      sprintf(
        "Ayat %s tidak ditemukan dalam surat %s.",
        paste(ayat_tidak_ditemukan, collapse = ", "),
        nomor_surat
      )
    )
  }

  # Urutkan sesuai urutan ayat dalam Al-Qur'an
  hasil <- hasil[order(hasil$ayat), , drop = FALSE]

  # Reset row names
  rownames(hasil) <- NULL

  hasil
}
