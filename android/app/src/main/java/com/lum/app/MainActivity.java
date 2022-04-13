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
import androidx.core.content.ContextCompat;
import androidx.media.VolumeProviderCompat;

import java.util.ArrayList;
import java.util.List;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private String CHANNEL = "com.lum.volume";
    private Intent forService;
    public static List<Integer> directionList = new ArrayList<Integer>();
    private static final int MY_PERMISSIONS_REQUEST_SEND_SMS =0 ;
    private static MediaSessionCompat mediaSession;
    private String phoneNo = "+5585988286381";
    String message = "Hey, im friend";
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
                    String resultMethod = start();
                    result.success(resultMethod);
                }
            }
        });
    }

    public String start(){
        Log.d("List","list len "+directionList.size());
        String[] result = {"STATUS.AWAIT"};

        directionList.clear();
        mediaSession = new MediaSessionCompat(this, "VolumeBackgroundService");
        mediaSession.setFlags(MediaSessionCompat.FLAG_HANDLES_MEDIA_BUTTONS |
                MediaSessionCompat.FLAG_HANDLES_TRANSPORT_CONTROLS);
        mediaSession.setPlaybackState(new PlaybackStateCompat.Builder()
                .setState(PlaybackStateCompat.STATE_PLAYING, 0, 0) //you simulate a player which plays something.
                .build());
        VolumeProviderCompat myVolumeProvider =
                new VolumeProviderCompat(VolumeProviderCompat.VOLUME_CONTROL_RELATIVE, /*max volume*/100, /*initial volume level*/50) {
                    @Override
                    public void onAdjustVolume(int direction) {
                        /*
                        -1 -- volume down
                        1 -- volume up
                        0 -- volume button released
                         */
                        if(direction == 1){
                            directionList.add(direction);
                            if(directionList.size() >= 3){
                                result[0] = "STATUS.DONE";
                                Log.d("STAUTUS VOLUME NATIVE","--------------------------"+result[0]);
                                sendSMS();
                                directionList.clear();
                            }
                        }
                    }
                };

        mediaSession.setPlaybackToRemote(myVolumeProvider);
        mediaSession.setActive(true);
        return result[0];
    }

    public void sendSMS(){

        String message = "Hy, every";
        String number = "6505551212";

        SmsManager mySmsManager = SmsManager.getDefault();
        mySmsManager.sendTextMessage(number,null, message, null, null);
    }



    @Override
    protected void onDestroy() {
        super.onDestroy();
        stopService(forService);
    }
}
