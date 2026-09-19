test_that("surat() returns the correct ayat for every surat", {

  jumlah_ayat <- table(alquran_id$surat)

  for (s in 1:114) {

    hasil <- surat(s)

    expect_equal(
      nrow(hasil),
      unname(jumlah_ayat[as.character(s)])
    )

    expect_equal(
      hasil$surat,
      rep(s, nrow(hasil))
    )

    expect_equal(
      hasil$ayat,
      seq_len(nrow(hasil))
    )
  }
})
