test_that("Arabic and Indonesian text belong to the same verse", {

  hasil <- ayat(2, 255)

  expect_equal(nrow(hasil), 1)
  expect_equal(hasil$surat, 2)
  expect_equal(hasil$ayat, 255)

  expect_true(nchar(hasil$teks_ar) > 0)
  expect_true(nchar(hasil$teks_id) > 0)
})


test_that("Arabic and Indonesian data stay aligned across the Quran", {

  contoh <- list(
    c(1, 1),
    c(1, 7),
    c(2, 1),
    c(2, 255),
    c(36, 1),
    c(55, 1),
    c(112, 1),
    c(113, 5),
    c(114, 6)
  )

  for (pasangan in contoh) {

    hasil <- ayat(
      nomor_surat = pasangan[1],
      nomor_ayat = pasangan[2]
    )

    expect_equal(hasil$surat, pasangan[1])
    expect_equal(hasil$ayat, pasangan[2])

    expect_type(hasil$teks_ar, "character")
    expect_type(hasil$teks_id, "character")

    expect_true(nchar(hasil$teks_ar) > 0)
    expect_true(nchar(hasil$teks_id) > 0)
  }
})


test_that("surat() returns aligned Arabic and Indonesian data", {

  hasil <- surat(2)

  expect_equal(nrow(hasil), 286)
  expect_named(
    hasil,
    c("surat", "ayat", "teks_ar", "teks_id")
  )

  expect_equal(hasil$surat, rep(2, 286))
  expect_equal(hasil$ayat, 1:286)

  expect_true(all(nchar(hasil$teks_ar) > 0))
  expect_true(all(nchar(hasil$teks_id) > 0))
})

test_that("cari() returns Arabic text for Indonesian matches", {

  hasil <- cari("Allah")

  expect_true(nrow(hasil) > 0)

  expect_named(
    hasil,
    c("surat", "ayat", "teks_ar", "teks_id")
  )

  expect_true(all(nchar(hasil$teks_ar) > 0))
  expect_true(all(nchar(hasil$teks_id) > 0))

  expect_true(
    all(grepl("Allah", hasil$teks_id, ignore.case = TRUE))
  )
})
