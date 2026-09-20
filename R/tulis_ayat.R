#' Menulis ayat Al-Qur'an untuk Quarto
#'
#' Menampilkan teks Arab dan terjemahan bahasa Indonesia dalam format
#' kutipan yang siap digunakan dalam dokumen Quarto.
#'
#' @param surat Nomor surat Al-Qur'an.
#' @param ayat Nomor ayat atau beberapa nomor ayat.
#' @param gaya Gaya tampilan. Pilihan: `"kutipan"` untuk kutipan dalam
#'   artikel atau `"baca"` untuk tampilan seperti pembaca Al-Qur'an.
#'
#' @return Objek HTML yang dapat dirender oleh Quarto.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   tulis_ayat(1, 1)
#'   tulis_ayat(2, 1:5)
#'   tulis_ayat(2, 255)
#'   tulis_ayat(2, 1:5, gaya = "baca")
#'   tulis_ayat(2, 286, bagian = 1)
#'   tulis_ayat(2, 286, bagian = 3:5)
#' }
tulis_ayat <- function(
    surat,
    ayat,
    bagian = NULL,
    gaya = "kutipan"
) {

  # ============================================================
  # VALIDASI INPUT
  # ============================================================

  if (length(surat) != 1 ||
      !is.numeric(surat) ||
      is.na(surat) ||
      surat %% 1 != 0 ||
      surat < 1 ||
      surat > 114) {
    stop("`surat` harus berupa satu nomor surat antara 1 dan 114.")
  }

  if (!is.numeric(ayat) ||
      any(is.na(ayat)) ||
      any(ayat %% 1 != 0) ||
      any(ayat < 1)) {
    stop("`ayat` harus berupa satu atau beberapa nomor ayat positif.")
  }

  gaya <- match.arg(gaya, c("kutipan", "baca"))

  if (!is.null(bagian) &&
      (!is.numeric(bagian) ||
       any(is.na(bagian)) ||
       any(bagian %% 1 != 0) ||
       any(bagian < 1))) {
    stop("`bagian` harus berupa satu atau beberapa nomor bagian positif.")
  }

  # ============================================================
  # AMBIL DATA
  # ============================================================

  data <- alquRanid::ayat(surat, ayat)

  if (nrow(data) == 0) {
    stop("Ayat yang diminta tidak ditemukan.")
  }

  if (!is.null(bagian)) {

    if (nrow(data) != 1) {
      stop("`bagian` hanya dapat digunakan untuk satu ayat.")
    }

    semua_bagian <- pecah_bagian(data$teks_ar[1])

    if (any(bagian > length(semua_bagian))) {
      stop(
        "`bagian` melebihi jumlah bagian yang tersedia. ",
        "Ayat ini memiliki ",
        length(semua_bagian),
        " bagian."
      )
    }

    data$teks_ar <- paste(
      semua_bagian[bagian],
      collapse = " "
    )
  }


  # ============================================================
  # NAMA SURAT
  # ============================================================

  nama_surat <- c(
    "Al-Fatihah",
    "Al-Baqarah",
    "Ali 'Imran",
    "An-Nisa",
    "Al-Ma'idah",
    "Al-An'am",
    "Al-A'raf",
    "Al-Anfal",
    "At-Taubah",
    "Yunus",
    "Hud",
    "Yusuf",
    "Ar-Ra'd",
    "Ibrahim",
    "Al-Hijr",
    "An-Nahl",
    "Al-Isra",
    "Al-Kahf",
    "Maryam",
    "Ta-Ha",
    "Al-Anbiya",
    "Al-Hajj",
    "Al-Mu'minun",
    "An-Nur",
    "Al-Furqan",
    "Asy-Syu'ara",
    "An-Naml",
    "Al-Qasas",
    "Al-'Ankabut",
    "Ar-Rum",
    "Luqman",
    "As-Sajdah",
    "Al-Ahzab",
    "Saba",
    "Fatir",
    "Ya-Sin",
    "As-Saffat",
    "Sad",
    "Az-Zumar",
    "Ghafir",
    "Fussilat",
    "Asy-Syura",
    "Az-Zukhruf",
    "Ad-Dukhan",
    "Al-Jasiyah",
    "Al-Ahqaf",
    "Muhammad",
    "Al-Fath",
    "Al-Hujurat",
    "Qaf",
    "Az-Zariyat",
    "At-Tur",
    "An-Najm",
    "Al-Qamar",
    "Ar-Rahman",
    "Al-Waqi'ah",
    "Al-Hadid",
    "Al-Mujadilah",
    "Al-Hasyr",
    "Al-Mumtahanah",
    "As-Saff",
    "Al-Jumu'ah",
    "Al-Munafiqun",
    "At-Tagabun",
    "At-Talaq",
    "At-Tahrim",
    "Al-Mulk",
    "Al-Qalam",
    "Al-Haqqah",
    "Al-Ma'arij",
    "Nuh",
    "Al-Jinn",
    "Al-Muzzammil",
    "Al-Muddatstsir",
    "Al-Qiyamah",
    "Al-Insan",
    "Al-Mursalat",
    "An-Naba",
    "An-Nazi'at",
    "Abasa",
    "At-Takwir",
    "Al-Infitar",
    "Al-Mutaffifin",
    "Al-Insyiqaq",
    "Al-Buruj",
    "At-Tariq",
    "Al-A'la",
    "Al-Gasyiyah",
    "Al-Fajr",
    "Al-Balad",
    "Asy-Syams",
    "Al-Lail",
    "Ad-Duha",
    "Al-Insyirah",
    "At-Tin",
    "Al-'Alaq",
    "Al-Qadr",
    "Al-Bayyinah",
    "Az-Zalzalah",
    "Al-'Adiyat",
    "Al-Qari'ah",
    "At-Takatsur",
    "Al-'Asr",
    "Al-Humazah",
    "Al-Fil",
    "Quraisy",
    "Al-Ma'un",
    "Al-Kausar",
    "Al-Kafirun",
    "An-Nasr",
    "Al-Lahab",
    "Al-Ikhlas",
    "Al-Falaq",
    "An-Nas"
  )


  # ============================================================
  # MEMBUAT HTML SETIAP AYAT
  # ============================================================

  isi <- paste(
    vapply(seq_len(nrow(data)), function(i) {

      paste0(

        '<div class="alquRanid-item">',

        # Teks Arab
        '<div class="alquRanid-arab">',
        '<span class="alquRanid-teks-arab">',
        htmltools::htmlEscape(data$teks_ar[i]),
        '</span>',
        '</div>',

        # Terjemahan
        '<div class="alquRanid-terjemahan">',
        htmltools::htmlEscape(data$teks_id[i]),
        '</div>',

        '</div>'

      )

    }, character(1)),
    collapse = "\n"
  )


  # ============================================================
  # REFERENSI
  # ============================================================

  referensi_ayat <- if (length(ayat) == 1) {
    as.character(ayat)
  } else if (all(diff(ayat) == 1)) {
    paste0(min(ayat), "-", max(ayat))
  } else {
    paste(ayat, collapse = ", ")
  }

  referensi <- paste0(
    "QS. ",
    nama_surat[surat],
    " ",
    surat,
    ":",
    referensi_ayat
  )

  # ============================================================
  # CSS UMUM
  # ============================================================

  css_umum <- '

    /* ========================================================
       QUOTATION CONTAINER
       ======================================================== */

    .alquRanid {

      margin: 2rem 0;

      padding: 2.25rem 2.5rem;

      background: #f5f5f5;

      border-radius: 0.5rem;

      box-sizing: border-box;
    }


    /* ========================================================
       SETIAP AYAT
       ======================================================== */

    .alquRanid-item {

      margin-bottom: 2.25rem;
    }

    .alquRanid-item:last-child {

      margin-bottom: 0;
    }


    /* ========================================================
       TEKS ARAB
       ======================================================== */

    .alquRanid-arab {

      direction: rtl;

      text-align: center;

      font-family:
        "Amiri",
        "Noto Naskh Arabic",
        "Traditional Arabic",
        serif;

      font-size: 2rem;

      font-weight: 400;

      line-height: 2.4;

      margin-bottom: 0.85rem;
    }

    .alquRanid-teks-arab {

      direction: rtl;
    }


    /* ========================================================
       TERJEMAHAN
       ======================================================== */

    .alquRanid-terjemahan {

      max-width: 720px;

      margin: 0 auto;

      direction: ltr;

      text-align: center;

      font-family:
        system-ui,
        -apple-system,
        BlinkMacSystemFont,
        "Segoe UI",
        sans-serif;

      font-size: 1rem;

      line-height: 1.8;
    }


    /* ========================================================
       REFERENSI
       ======================================================== */

    .alquRanid-referensi {

      margin-top: 2rem;

      padding-top: 1rem;

      border-top: 1px solid rgba(0, 0, 0, 0.12);

      text-align: center;

      font-family:
        system-ui,
        -apple-system,
        BlinkMacSystemFont,
        "Segoe UI",
        sans-serif;

      font-size: 0.85rem;

      font-style: italic;

      opacity: 0.65;
    }


    /* ========================================================
       MOBILE
       ======================================================== */

    @media (max-width: 768px) {

      .alquRanid {

        padding: 1.5rem 1.25rem;

        margin: 1.5rem 0;
      }

      .alquRanid-item {

        margin-bottom: 2rem;
      }

      .alquRanid-arab {

        font-size: 1.7rem;

        line-height: 2.35;
      }

      .alquRanid-terjemahan {

        max-width: 100%;

        font-size: 0.98rem;
      }
    }
  '


  # ============================================================
  # CSS KHUSUS GAYA KUTIPAN
  # ============================================================

  css_kutipan <- '

    .alquRanid-kutipan {

      text-align: center;
    }

    .alquRanid-kutipan .alquRanid-arab {

      text-align: center;
    }

    .alquRanid-kutipan .alquRanid-terjemahan {

      text-align: center;
    }

  '


  # ============================================================
  # CSS KHUSUS GAYA BACA
  # ============================================================

  css_baca <- '

    .alquRanid-baca {

      text-align: initial;
    }

    .alquRanid-baca .alquRanid-arab {

      text-align: right;
    }

    .alquRanid-baca .alquRanid-terjemahan {

      max-width: none;

      margin: 0;

      text-align: left;
    }

    .alquRanid-baca .alquRanid-referensi {

      text-align: left;
    }

  '


  # ============================================================
  # PILIH GAYA
  # ============================================================

  kelas_gaya <- if (gaya == "kutipan") {
    "alquRanid-kutipan"
  } else {
    "alquRanid-baca"
  }

  css_gaya <- if (gaya == "kutipan") {
    css_kutipan
  } else {
    css_baca
  }


  # ============================================================
  # HTML
  # ============================================================

  html <- paste0(

    '<div class="alquRanid ',
    kelas_gaya,
    '">',

    '<style>',

    '@import url(',
    '"https://fonts.googleapis.com/css2?',
    'family=Amiri:wght@400;700&display=swap"',
    ');',

    css_umum,

    css_gaya,

    '</style>',

    isi,

    '<div class="alquRanid-referensi">',
    htmltools::htmlEscape(referensi),
    '</div>',

    '</div>'
  )


  # ============================================================
  # RETURN
  # ============================================================

  htmltools::HTML(html)
}
