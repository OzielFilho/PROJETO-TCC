package com.lum.app;

import android.Manifest;
import android.annotation.TargetApi;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Intent;
import android.content.pm.PackageManager;

import android.os.Build;
import android.os.Bundle;
import android.support.v4.media.session.MediaSessionCompat;
import android.support.v4.media.session.PlaybackStateCompat;
import android.telephony.SmsManager;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;

import androidx.media.VolumeProviderCompat;
import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private final String CHANNEL = "com.lum.volume";
    private Intent forService;
    public static ArrayList directionList = new ArrayList();
    public static List<String> phones = new ArrayList();
    private static MediaSessionCompat mediaSession;

    String message = "Olá";
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(getFlutterEngine());
        ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.SEND_SMS, Manifest.permission.READ_SMS}, PackageManager.PERMISSION_GRANTED);
        forService = new Intent(this, VolumeBackgroundService.class);
        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(),CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if(call.method.equals("startService")){
                    phones = call.argument("phones");
                    start();
                    result.success("SUCESSO");
                }
            }
        });
    }

    public VolumeProviderCompat myVolumeProvider(){
        String[] result = {"STATUS.AWAIT"};
        //directionList.clear();
        return new VolumeProviderCompat(VolumeProviderCompat.VOLUME_CONTROL_RELATIVE, 100, 50) {
            @RequiresApi(api = Build.VERSION_CODES.O)
            @Override
            public void onAdjustVolume(int direction) {
                /* -1 -- volume down  1 -- volume up 0 -- volume button released */
                if(direction !=-1) {
                    directionList.add("" + direction);
                    if (directionList.toString().contains("1, 0, 1, 0, 1, 0") || directionList.toString().contains("1, 0, 1, 0, 1, 0, 1, 0")) {
                        Log.d("VOLUME_STATUS", "DEU BOM");
                        directionList.clear();
                    }

                }}
        };
    }


    public void start(){

        VolumeProviderCompat myVolumePr = myVolumeProvider();

        createMediaSession(myVolumePr);

    }

    private void createMediaSession(VolumeProviderCompat myVolumeProvider) {
        mediaSession = new MediaSessionCompat(this, "VolumeBackgroundService");

        mediaSession.setFlags(MediaSessionCompat.FLAG_HANDLES_MEDIA_BUTTONS |
                MediaSessionCompat.FLAG_HANDLES_TRANSPORT_CONTROLS);
        mediaSession.setPlaybackState(new PlaybackStateCompat.Builder()
                .setState(PlaybackStateCompat.STATE_PLAYING, 0, 0)
                .build());
        mediaSession.setPlaybackToRemote(myVolumeProvider);
        mediaSession.setActive(true);
    }


    @Override
    protected void onDestroy() {
        super.onDestroy();
        stopService(forService);
    }
}
