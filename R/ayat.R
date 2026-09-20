#' Mengambil teks ayat Al-Qur'an
#'
#' Mengambil teks Arab dan terjemahan bahasa Indonesia berdasarkan
#' nomor surat dan nomor ayat.
#'
#' @param nomor_surat Nomor surat Al-Qur'an.
#' @param nomor_ayat Nomor ayat atau beberapa nomor ayat.
#'
#' @return Data frame berisi nomor surat, nomor ayat, teks Arab,
#'   dan terjemahan bahasa Indonesia.
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

  # Ambil dataset paket
  data("alquran", package = "alquRanid")

  # Ambil ayat
  hasil <- alquran[
    alquran$surat == nomor_surat &
      alquran$ayat %in% nomor_ayat,
    ,
    drop = FALSE
  ]

  # Validasi hasil
  if (nrow(hasil) == 0) {
    stop(
      sprintf(
        "Ayat %s tidak ditemukan dalam surat %s.",
        paste(nomor_ayat, collapse = ", "),
        nomor_surat
      )
    )
  }

  ayat_tidak_ditemukan <- setdiff(nomor_ayat, hasil$ayat)

  if (length(ayat_tidak_ditemukan) > 0) {
    stop(
      sprintf(
        "Ayat %s tidak ditemukan dalam surat %s.",
        paste(ayat_tidak_ditemukan, collapse = ", "),
        nomor_surat
      )
    )
  }

  hasil <- hasil[order(hasil$ayat), , drop = FALSE]

  rownames(hasil) <- NULL

  hasil
}
