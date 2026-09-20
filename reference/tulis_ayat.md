# Menulis ayat Al-Qur'an untuk Quarto

Menampilkan teks Arab dan terjemahan bahasa Indonesia dalam format
kutipan yang siap digunakan dalam dokumen Quarto.

## Usage

``` r
tulis_ayat(surat, ayat, bagian = NULL, gaya = "kutipan")
```

## Arguments

- surat:

  Nomor surat Al-Qur'an.

- ayat:

  Nomor ayat atau beberapa nomor ayat.

- gaya:

  Gaya tampilan. Pilihan: `"kutipan"` untuk kutipan dalam artikel atau
  `"baca"` untuk tampilan seperti pembaca Al-Qur'an.

## Value

Objek HTML yang dapat dirender oleh Quarto.

## Examples

``` r
if (interactive()) {
  tulis_ayat(1, 1)
  tulis_ayat(2, 1:5)
  tulis_ayat(2, 255)
  tulis_ayat(2, 1:5, gaya = "baca")
  tulis_ayat(2, 286, bagian = 1)
  tulis_ayat(2, 286, bagian = 3:5)
}
```
