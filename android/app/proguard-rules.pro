
-keep class com.huawei.** { *; }


-keep class org.bouncycastle.** { *; }


-keep class okhttp3.** { *; }


-keepclassmembers class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}


-keepattributes *Annotation*