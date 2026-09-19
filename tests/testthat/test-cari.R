test_that("cari() menemukan kata", {

  hasil <- cari("Allah")

  expect_s3_class(hasil, "data.frame")
  expect_gt(nrow(hasil), 0)

  expect_true(all(grepl(
    "Allah",
    hasil$teks_id,
    ignore.case = TRUE
  )))
})


test_that("cari() tidak sensitif terhadap huruf besar kecil", {

  hasil_besar <- cari("Allah")
  hasil_kecil <- cari("allah")

  expect_equal(
    hasil_besar[, c("surat", "ayat")],
    hasil_kecil[, c("surat", "ayat")]
  )
})


test_that("cari() dapat mencari frasa", {

  hasil <- cari("orang-orang")

  expect_s3_class(hasil, "data.frame")
  expect_gt(nrow(hasil), 0)
})


test_that("cari() mengembalikan data frame kosong jika tidak ditemukan", {

  hasil <- cari("xyzzyquran")

  expect_s3_class(hasil, "data.frame")
  expect_equal(nrow(hasil), 0)
  expect_named(
    hasil,
    c("surat", "ayat", "teks_ar", "teks_id")
  )
})


test_that("cari() menolak input kosong", {

  expect_error(cari(""))
  expect_error(cari("   "))
})


test_that("cari() menolak input tidak valid", {

  expect_error(cari(123))
  expect_error(cari(NA))
  expect_error(cari(NULL))
})


test_that("cari() treats search text literally", {

  expect_no_error(cari("."))
  expect_no_error(cari("+"))
  expect_no_error(cari("("))
  expect_no_error(cari("["))
})

test_that("cari() returns the expected columns when there are no matches", {

  hasil <- cari("xyzzyquran")

  expect_equal(
    names(hasil),
    c("surat", "ayat", "teks_ar", "teks_id")
  )

  expect_equal(nrow(hasil), 0)
  expect_equal(ncol(hasil), 4)
})


test_that("cari() rejects multiple search terms", {

  expect_error(cari(c("Allah", "rahmat")))
})


test_that("cari() handles regex-looking characters literally", {

  expect_no_error(cari("."))
  expect_no_error(cari("+"))
  expect_no_error(cari("("))
  expect_no_error(cari("["))
})


test_that("cari() preserves the expected columns", {

  hasil <- cari("Allah")

  expect_named(
    hasil,
    c("surat", "ayat", "teks_ar", "teks_id")
  )
})


test_that("cari() returns valid surat and ayat numbers", {

  hasil <- cari("Allah")

  expect_true(all(hasil$surat >= 1))
  expect_true(all(hasil$surat <= 114))
  expect_true(all(hasil$ayat >= 1))
})


test_that("cari() rejects multiple search terms", {

  expect_error(
    cari(c("Allah", "rahmat"))
  )
})


test_that("cari() handles regex-looking characters literally", {

  expect_no_error(cari("."))
  expect_no_error(cari("+"))
  expect_no_error(cari("("))
  expect_no_error(cari("["))
})


test_that("cari() preserves the expected columns", {

  hasil <- cari("Allah")

  expect_named(
    hasil,
    c("surat", "ayat", "teks_ar", "teks_id")
  )
})


test_that("cari() returns valid surat and ayat numbers", {

  hasil <- cari("Allah")

  expect_true(all(hasil$surat >= 1))
  expect_true(all(hasil$surat <= 114))
  expect_true(all(hasil$ayat >= 1))
})


test_that("cari() rejects multiple search terms", {

  expect_error(
    cari(c("Allah", "rahmat"))
  )
})
