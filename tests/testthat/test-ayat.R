test_that("ayat() returns one ayat", {

  hasil <- ayat(1, 1)

  expect_s3_class(hasil, "data.frame")
  expect_equal(nrow(hasil), 1)
  expect_equal(hasil$surat, 1)
  expect_equal(hasil$ayat, 1)
  expect_true(nzchar(hasil$teks_id))
})


test_that("ayat() works for a middle ayat", {

  hasil <- ayat(2, 255)

  expect_equal(nrow(hasil), 1)
  expect_equal(hasil$surat, 2)
  expect_equal(hasil$ayat, 255)
  expect_true(nzchar(hasil$teks_id))
})


test_that("ayat() works for the final ayat", {

  hasil <- ayat(114, 6)

  expect_equal(nrow(hasil), 1)
  expect_equal(hasil$surat, 114)
  expect_equal(hasil$ayat, 6)
})


test_that("ayat() rejects invalid surat numbers", {

  expect_error(ayat(0, 1))
  expect_error(ayat(115, 1))
  expect_error(ayat(-1, 1))
})


test_that("ayat() rejects invalid ayat numbers", {

  expect_error(ayat(2, 0))
  expect_error(ayat(2, -1))
  expect_error(ayat(2, 287))
  expect_error(ayat(114, 7))
})


test_that("ayat() handles boundaries for every surat", {

  jumlah_ayat <- table(alquran_id$surat)

  for (s in 1:114) {

    maksimum <- unname(jumlah_ayat[as.character(s)])

    # First ayat must exist
    hasil_awal <- ayat(s, 1)

    expect_equal(nrow(hasil_awal), 1)
    expect_equal(hasil_awal$surat, s)
    expect_equal(hasil_awal$ayat, 1)

    # Last ayat must exist
    hasil_akhir <- ayat(s, maksimum)

    expect_equal(nrow(hasil_akhir), 1)
    expect_equal(hasil_akhir$surat, s)
    expect_equal(hasil_akhir$ayat, maksimum)

    # One ayat beyond the end must fail
    expect_error(ayat(s, maksimum + 1))
  }
})
test_that("ayat() rejects fractional numbers", {

  expect_error(ayat(1.5, 1))
  expect_error(ayat(1, 1.5))
})


test_that("ayat() rejects invalid types", {

  expect_error(ayat("2", 255))
  expect_error(ayat(2, "255"))
  expect_error(ayat(NA, 1))
  expect_error(ayat(2, NA))
  expect_error(ayat(NULL, 1))
  expect_error(ayat(2, NULL))
})


test_that("ayat() handles boundaries for every surat", {

  jumlah_ayat <- table(alquran_id$surat)

  for (s in 1:114) {

    maksimum <- unname(jumlah_ayat[as.character(s)])

    # First ayat must exist
    hasil_awal <- ayat(s, 1)

    expect_equal(nrow(hasil_awal), 1)
    expect_equal(hasil_awal$surat, s)
    expect_equal(hasil_awal$ayat, 1)

    # Last ayat must exist
    hasil_akhir <- ayat(s, maksimum)

    expect_equal(nrow(hasil_akhir), 1)
    expect_equal(hasil_akhir$surat, s)
    expect_equal(hasil_akhir$ayat, maksimum)

    # One ayat beyond the end must fail
    expect_error(ayat(s, maksimum + 1))
  }
})


test_that("ayat() supports multiple ayat", {

  hasil <- ayat(114, 1:3)

  expect_equal(nrow(hasil), 3)
  expect_equal(hasil$surat, c(114, 114, 114))
  expect_equal(hasil$ayat, c(1, 2, 3))

  expect_named(
    hasil,
    c("surat", "ayat", "teks_ar", "teks_id")
  )

  expect_true(all(nchar(hasil$teks_ar) > 0))
  expect_true(all(nchar(hasil$teks_id) > 0))
})

test_that("ayat() accepts selected ayat", {

  hasil <- ayat(114, c(3, 1, 2))

  expect_equal(hasil$ayat, c(1, 2, 3))
})

test_that("ayat() supports ranges within a surah", {

  hasil <- ayat(2, 255:256)

  expect_equal(nrow(hasil), 2)
  expect_equal(hasil$surat, c(2, 2))
  expect_equal(hasil$ayat, c(255, 256))
})

test_that("ayat() rejects a range containing a nonexistent ayah", {

  expect_error(
    ayat(114, c(1, 7)),
    "Ayat 7 tidak ditemukan"
  )
})

test_that("ayat() rejects non-positive ayat", {

  expect_error(
    ayat(114, 0),
    "nomor_ayat harus berupa bilangan positif"
  )

  expect_error(
    ayat(114, -1),
    "nomor_ayat harus berupa bilangan positif"
  )
})

test_that("ayat() rejects missing ayat", {

  expect_error(
    ayat(114, NA),
    "nomor_ayat harus berupa angka"
  )

  expect_error(
    ayat(114, c(1, NA)),
    "nomor_ayat harus berupa angka"
  )
})

