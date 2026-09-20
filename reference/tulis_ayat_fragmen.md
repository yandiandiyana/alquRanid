# Menulis fragmen ayat Al-Qur'an untuk Quarto

Menampilkan satu atau beberapa bagian dari teks Arab ayat berdasarkan
tanda waqaf.

## Usage

``` r
tulis_ayat_fragmen(surat, ayat, bagian = NULL)
```

## Arguments

- surat:

  Nomor surat Al-Qur'an.

- ayat:

  Nomor ayat.

- bagian:

  Nomor bagian ayat yang ingin ditampilkan. Jika `NULL`, semua bagian
  ditampilkan.

## Value

Objek HTML yang dapat dirender oleh Quarto.

## Examples

``` r
if (interactive()) {
  tulis_ayat_fragmen(2, 2)
  tulis_ayat_fragmen(2, 286, 7)
  tulis_ayat_fragmen(2, 286, 3:5)
}
```
