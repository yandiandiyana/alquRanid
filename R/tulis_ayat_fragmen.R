#' Menulis fragmen ayat Al-Qur'an untuk Quarto
#'
#' Menampilkan satu atau beberapa bagian dari teks Arab ayat
#' berdasarkan tanda waqaf.
#'
#' @param surat Nomor surat Al-Qur'an.
#' @param ayat Nomor ayat.
#' @param bagian Nomor bagian ayat yang ingin ditampilkan.
#'   Jika `NULL`, semua bagian ditampilkan.
#'
#' @return Objek HTML yang dapat dirender oleh Quarto.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   tulis_ayat_fragmen(2, 2)
#'   tulis_ayat_fragmen(2, 286, 7)
#'   tulis_ayat_fragmen(2, 286, 3:5)
#' }
tulis_ayat_fragmen <- function(
    surat,
    ayat,
    bagian = NULL
) {

  # Validasi surat
  if (length(surat) != 1 ||
      !is.numeric(surat) ||
      is.na(surat) ||
      surat < 1 ||
      surat > 114 ||
      surat %% 1 != 0) {
    stop("`surat` harus berupa satu nomor surat antara 1 dan 114.")
  }

  # Validasi ayat
  if (length(ayat) != 1 ||
      !is.numeric(ayat) ||
      is.na(ayat) ||
      ayat < 1 ||
      ayat %% 1 != 0) {
    stop("`ayat` harus berupa satu nomor ayat berupa bilangan bulat positif.")
  }

  # Ambil data ayat
  data <- alquRanid::ayat(surat, ayat)

  if (nrow(data) == 0) {
    stop(sprintf(
      "Ayat %s:%s tidak ditemukan.",
      surat,
      ayat
    ))
  }

  # Pecah teks Arab
  semua_bagian <- alquRanid:::pecah_bagian(data$teks_ar[1])

  jumlah_bagian <- length(semua_bagian)

  # Validasi bagian
  if (!is.null(bagian)) {

    if (!is.numeric(bagian) ||
        length(bagian) == 0 ||
        any(is.na(bagian)) ||
        any(bagian %% 1 != 0) ||
        any(bagian < 1) ||
        any(bagian > jumlah_bagian)) {
      stop(sprintf(
        "`bagian` harus berupa nomor antara 1 dan %s.",
        jumlah_bagian
      ))
    }

    semua_bagian <- semua_bagian[bagian]
  }

  # Nama surat
  nama_surat <- c(
    "Al-Fatihah",
    "Al-Baqarah",
    "Ali 'Imran",
    "An-Nisa'",
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
    "Al-Isra'",
    "Al-Kahf",
    "Maryam",
    "Ta-Ha",
    "Al-Anbiya'",
    "Al-Hajj",
    "Al-Mu'minun",
    "An-Nur",
    "Al-Furqan",
    "Asy-Syu'ara'",
    "An-Naml",
    "Al-Qasas",
    "Al-'Ankabut",
    "Ar-Rum",
    "Luqman",
    "As-Sajdah",
    "Al-Ahzab",
    "Saba'",
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
    "Al-Muddassir",
    "Al-Qiyamah",
    "Al-Insan",
    "Al-Mursalat",
    "An-Naba'",
    "An-Nazi'at",
    "'Abasa",
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
    "Asy-Syarh",
    "At-Tin",
    "Al-'Alaq",
    "Al-Qadr",
    "Al-Bayyinah",
    "Az-Zalzalah",
    "Al-'Adiyat",
    "Al-Qari'ah",
    "At-Takasur",
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

  nama <- nama_surat[surat]

  # HTML fragmen
  html_fragmen <- paste(
    sprintf(
      paste0(
        '<div class="alquRanid-fragmen">',
        '<div class="alquRanid-teks">%s</div>',
        '<div class="alquRanid-referensi"><em>QS. %s %s:%s</em></div>',
        '</div>'
      ),
      semua_bagian,
      nama,
      surat,
      ayat
    ),
    collapse = "\n"
  )

  # CSS
  css <- '
<style>
.alquRanid-fragmen {
  direction: rtl;
  text-align: center;
  background-color: #f2f2f2;
  font-family: "Amiri", "Noto Naskh Arabic", serif;
  padding: 1.2em 1.5em;
  margin: 1em auto;
  border-radius: 6px;
}

.alquRanid-teks {
  font-size: 1.8em;
  line-height: 2.2;
}

.alquRanid-referensi {
  direction: ltr;
  text-align: center;
  font-family: sans-serif;
  font-size: 0.9em;
  margin-top: 0.8em;
  opacity: 0.7;
}
</style>
'

htmltools::HTML(paste0(css, html_fragmen))
}
