# Ambil satu ayat dari Al-Qur'an

Mengembalikan satu ayat berdasarkan nomor surat dan nomor ayat.

## Usage

``` r
ayat(nomor_surat, nomor_ayat)
```

## Arguments

- nomor_surat:

  Nomor surat, dari 1 sampai 114.

- nomor_ayat:

  Nomor ayat, berupa satu angka atau beberapa angka.

## Value

Data frame dengan satu baris berisi nomor surat, nomor ayat, dan
terjemahan Indonesia.

## Examples

``` r
ayat(1, 1)
#> Error in ayat(1, 1): could not find function "ayat"
ayat(2, 255)
#> Error in ayat(2, 255): could not find function "ayat"
ayat(114, 1:3)
#> Error in ayat(114, 1:3): could not find function "ayat"
ayat(2, c(255, 256))
#> Error in ayat(2, c(255, 256)): could not find function "ayat"
```
