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
#>   surat ayat                 teks_ar
#> 1     1    1 بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ
#>                                                             teks_id
#> 1 Dengan menyebut nama Allah Yang Maha Pemurah lagi Maha Penyayang.
ayat(2, 255)
#>   surat ayat
#> 1     2  255
#>                                                                                                                                                                                                                                                   teks_ar
#> 1 اللَّهُ لَا إِلَـٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 teks_id
#> 1 Allah, tidak ada Tuhan (yang berhak disembah) melainkan Dia Yang Hidup kekal lagi terus menerus mengurus (makhluk-Nya); tidak mengantuk dan tidak tidur. Kepunyaan-Nya apa yang di langit dan di bumi. Tiada yang dapat memberi syafa'at di sisi Allah tanpa izin-Nya? Allah mengetahui apa-apa yang di hadapan mereka dan di belakang mereka, dan mereka tidak mengetahui apa-apa dari ilmu Allah melainkan apa yang dikehendaki-Nya. Kursi Allah meliputi langit dan bumi. Dan Allah tidak merasa berat memelihara keduanya, dan Allah Maha Tinggi lagi Maha Besar.
ayat(114, 1:3)
#>   surat ayat           teks_ar
#> 1   114    1 قُلْ أَعُوذُ بِرَبِّ النَّاسِ
#> 2   114    2         مَلِكِ النَّاسِ
#> 3   114    3        إِلَـٰهِ النَّاسِ
#>                                                                             teks_id
#> 1 Katakanlah: "Aku berlindung kepada Tuhan (yang memelihara dan menguasai) manusia.
#> 2                                                                     Raja manusia.
#> 3                                                                 Sembahan manusia.
ayat(2, c(255, 256))
#>   surat ayat
#> 1     2  255
#> 2     2  256
#>                                                                                                                                                                                                                                                   teks_ar
#> 1 اللَّهُ لَا إِلَـٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَّهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ ۗ مَن ذَا الَّذِي يَشْفَعُ عِندَهُ إِلَّا بِإِذْنِهِ ۚ يَعْلَمُ مَا بَيْنَ أَيْدِيهِمْ وَمَا خَلْفَهُمْ ۖ وَلَا يُحِيطُونَ بِشَيْءٍ مِّنْ عِلْمِهِ إِلَّا بِمَا شَاءَ ۚ وَسِعَ كُرْسِيُّهُ السَّمَاوَاتِ وَالْأَرْضَ ۖ وَلَا يَئُودُهُ حِفْظُهُمَا ۚ وَهُوَ الْعَلِيُّ الْعَظِيمُ
#> 2                                                                                                                        لَا إِكْرَاهَ فِي الدِّينِ ۖ قَد تَّبَيَّنَ الرُّشْدُ مِنَ الْغَيِّ ۚ فَمَن يَكْفُرْ بِالطَّاغُوتِ وَيُؤْمِن بِاللَّهِ فَقَدِ اسْتَمْسَكَ بِالْعُرْوَةِ الْوُثْقَىٰ لَا انفِصَامَ لَهَا ۗ وَاللَّهُ سَمِيعٌ عَلِيمٌ
#>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 teks_id
#> 1 Allah, tidak ada Tuhan (yang berhak disembah) melainkan Dia Yang Hidup kekal lagi terus menerus mengurus (makhluk-Nya); tidak mengantuk dan tidak tidur. Kepunyaan-Nya apa yang di langit dan di bumi. Tiada yang dapat memberi syafa'at di sisi Allah tanpa izin-Nya? Allah mengetahui apa-apa yang di hadapan mereka dan di belakang mereka, dan mereka tidak mengetahui apa-apa dari ilmu Allah melainkan apa yang dikehendaki-Nya. Kursi Allah meliputi langit dan bumi. Dan Allah tidak merasa berat memelihara keduanya, dan Allah Maha Tinggi lagi Maha Besar.
#> 2                                                                                                                                                                                                                        Tidak ada paksaan untuk (memasuki) agama (Islam); sesungguhnya telah jelas jalan yang benar daripada jalan yang sesat. Karena itu barangsiapa yang ingkar kepada Thaghut dan beriman kepada Allah, maka sesungguhnya ia telah berpegang kepada buhul tali yang amat kuat yang tidak akan putus. Dan Allah Maha Mendengar lagi Maha Mengetahui.
```
