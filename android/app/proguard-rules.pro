# Keep all Huawei SDK classes
-keep class com.huawei.** { *; }

# Keep BouncyCastle crypto classes
-keep class org.bouncycastle.** { *; }

# Keep OkHttp classes
-keep class okhttp3.** { *; }

# Keep all Parcelable classes
-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# Keep annotations used in Huawei SDK
-keepattributes *Annotation*
