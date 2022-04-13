package com.lum.app;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.v4.media.session.MediaSessionCompat;
import android.support.v4.media.session.PlaybackStateCompat;
import android.telephony.SmsManager;
import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.app.NotificationManagerCompat;
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
    public static List<Integer> directionList = new ArrayList();
    public static List<String> phones = new ArrayList();
    private static MediaSessionCompat mediaSession;
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
                    phones = call.argument("phones");
                    start();
                    result.success("SUCESSO");
                }
            }
        });
    }

    public VolumeProviderCompat myVolumeProvider(){
        String[] result = {"STATUS.AWAIT"};
        directionList.clear();
        return new VolumeProviderCompat(VolumeProviderCompat.VOLUME_CONTROL_RELATIVE, 100, 50) {
            @Override
            public void onAdjustVolume(int direction) {
                /* -1 -- volume down  1 -- volume up 0 -- volume button released */
                if(direction == 1){
                    directionList.add(direction);
                    if(directionList.size() == 3){
                        result[0] = "STATUS.DONE";
                        Log.d("VOLUME_STATUS",result[0]);
                        sendSMS();
                        directionList.clear();
                    }
                }

            }
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

    public void setActive(boolean active) {
        if (mediaSession != null) {
            mediaSession.setActive(active);
            return;
        }
        createMediaSession(myVolumeProvider());
    }

    public void sendSMS(){
        for (int i = 0; i < phones.size(); i++) {
            SmsManager mySmsManager = SmsManager.getDefault();
            mySmsManager.sendTextMessage(phones.get(i),null, message+phones.get(i), null, null);
        }

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        stopService(forService);
    }
}
