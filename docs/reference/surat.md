# Ambil satu surat dari Al-Qur'an

Mengembalikan seluruh ayat dari surat yang dipilih, beserta teks Arab
dan terjemahan Bahasa Indonesia.

## Usage

``` r
surat(nomor)
```

## Arguments

- nomor:

  Nomor surat, dari 1 sampai 114.

## Value

Data frame berisi nomor surat, nomor ayat, teks Arab, dan terjemahan
Indonesia.

## Examples

``` r
surat(1)
#> Error in surat(1): could not find function "surat"
surat(2)
#> Error in surat(2): could not find function "surat"
surat(114)
#> Error in surat(114): could not find function "surat"
```
