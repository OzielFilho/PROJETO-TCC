package com.lum.app;

import android.Manifest;
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
import java.util.Objects;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private final String CHANNEL = "com.lum.volume";
    private static ArrayList directionList = new ArrayList();
    private static List<String> phones = new ArrayList();
    private static MediaSessionCompat mediaSession;

    private static boolean actionsActive = false;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(getFlutterEngine());
        ActivityCompat.requestPermissions(this,new String[]{Manifest.permission.SEND_SMS, Manifest.permission.READ_SMS}, PackageManager.PERMISSION_GRANTED);
        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(),CHANNEL).setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if(call.method.equals("startService")){
                    phones = call.argument("phones");
                    start();
                    result.success(actionsActive);
                }
                else if(call.method.equals("sendSms")){
                    Log.d("SMS","CONTATOS "+call.argument("contacts"));
                    sendSMS(Objects.requireNonNull(call.argument("contacts")));

                }
                else{
                    result.notImplemented();
                }
            }
        });
    }

    public VolumeProviderCompat myVolumeProvider(){
        actionsActive = false;
        return new VolumeProviderCompat(VolumeProviderCompat.VOLUME_CONTROL_RELATIVE, 100, 50) {
            @RequiresApi(api = Build.VERSION_CODES.O)
            @Override
            public void onAdjustVolume(int direction) {
                /* -1 -- volume down  1 -- volume up 0 -- volume button released */
                if(direction !=-1) {
                    directionList.add("" + direction);
                    if (directionList.toString().contains("1, 0, 1, 0, 1, 0") || directionList.toString().contains("1, 0, 1, 0, 1, 0, 1, 0")) {
                        actionsActive = true;
                        Log.d("VOLUME_STATUS", "DEU BOM");

                        directionList.clear();                     
                    }

                }}
        };
    }



    protected void start(){
        VolumeProviderCompat myVolumePr = myVolumeProvider();
        createMediaSession(myVolumePr);
    }

    protected void createMediaSession(VolumeProviderCompat myVolumeProvider) {
        mediaSession = new MediaSessionCompat(this, "VolumeBackgroundService");

        mediaSession.setFlags(MediaSessionCompat.FLAG_HANDLES_MEDIA_BUTTONS |
                MediaSessionCompat.FLAG_HANDLES_TRANSPORT_CONTROLS);
        mediaSession.setPlaybackState(new PlaybackStateCompat.Builder()
                .setState(PlaybackStateCompat.STATE_PLAYING, 0, 0)
                .build());
        mediaSession.setPlaybackToRemote(myVolumeProvider);
        mediaSession.setActive(true);
    }

    public void sendSMS(List<String> contacts){
        for (int i = 0; i < contacts.size(); i++) {
            SmsManager mySmsManager = SmsManager.getDefault();
            mySmsManager.sendTextMessage("55085997563129",null, "Olá"+contacts.get(i), null, null);
        }
    }

    private void toastCreate(String message){
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }
}
