# Detik: aturan R8. Flutter dan plugin sudah menyertakan aturan konsumen
# masing-masing; tambahan di bawah menjaga layanan alarm dan notifikasi.
-keep class com.gdelataillade.alarm.** { *; }
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-dontwarn com.google.android.play.core.**
