test_that("Indonesian Quran data has 6236 ayat", {
  expect_equal(
    nrow(alquran_id),
    6236
  )
})


test_that("Quran data has the expected columns", {
  expect_named(
    alquran_id,
    c("surat", "ayat", "teks_id")
  )
})


test_that("surat and ayat are integers", {
  expect_true(
    is.integer(alquran_id$surat)
  )

  expect_true(
    is.integer(alquran_id$ayat)
  )
})


test_that("surat numbers are valid", {
  expect_true(
    all(alquran_id$surat >= 1)
  )

  expect_true(
    all(alquran_id$surat <= 114)
  )
})


test_that("there are no missing ayat keys", {
  expect_false(
    any(is.na(alquran_id$surat))
  )

  expect_false(
    any(is.na(alquran_id$ayat))
  )
})


test_that("there are no missing translations", {
  expect_false(
    any(is.na(alquran_id$teks_id))
  )

  expect_false(
    any(trimws(alquran_id$teks_id) == "")
  )
})


test_that("surat and ayat combinations are unique", {
  kunci <- paste(
    alquran_id$surat,
    alquran_id$ayat,
    sep = ":"
  )

  expect_equal(
    length(unique(kunci)),
    nrow(alquran_id)
  )
})


test_that("ayat numbers are sequential within every surat", {
  for (s in 1:114) {

    ayat_surat <- alquran_id$ayat[
      alquran_id$surat == s
    ]

    expect_identical(
      ayat_surat,
      seq_len(length(ayat_surat))
    )
  }
})
