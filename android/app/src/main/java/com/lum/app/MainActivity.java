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
    private static ArrayList directionList = new ArrayList();
    private static List<String> phones = new ArrayList();
    private static MediaSessionCompat mediaSession;

    private static boolean actionsActive = true;

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
                    result.success("SUCESSO");
                }
            }
        });
    }

    public VolumeProviderCompat myVolumeProvider(){
        return new VolumeProviderCompat(VolumeProviderCompat.VOLUME_CONTROL_RELATIVE, 100, 50) {
            @RequiresApi(api = Build.VERSION_CODES.O)
            @Override
            public void onAdjustVolume(int direction) {
                /* -1 -- volume down  1 -- volume up 0 -- volume button released */
                if(direction !=-1) {
                    directionList.add("" + direction);
                    if (directionList.toString().contains("1, 0, 1, 0, 1, 0") || directionList.toString().contains("1, 0, 1, 0, 1, 0, 1, 0")) {
                        Log.d("VOLUME_STATUS", "DEU BOM");
                        if(actionsActive){
                            sendSMS();
                            showNotification();
                        }
                        directionList.clear();
                    }

                }}
        };
    }



    protected void start(){
        VolumeProviderCompat myVolumePr = myVolumeProvider();
        createMediaSession(myVolumePr);
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    @TargetApi(Build.VERSION_CODES.O)
    public void showNotification(){

        Intent intent=new Intent(getApplicationContext(),MainActivity.class);
        String CHANNEL_ID="MYCHANNEL";
        NotificationChannel notificationChannel= null;
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
            notificationChannel = new NotificationChannel(CHANNEL_ID,"name", NotificationManager.IMPORTANCE_DEFAULT);
        }
        PendingIntent pendingIntent=PendingIntent.getActivity(getApplicationContext(),1,intent,0);
        Notification notification=new Notification.Builder(getApplicationContext(),CHANNEL_ID)
                .setContentText("Ações com os botões ativos")
                .setContentTitle("Shh! Preciso de ajuda")
                .setContentIntent(pendingIntent)
                .addAction(android.R.drawable.sym_def_app_icon,"Ativar",pendingIntent)
                .setChannelId(CHANNEL_ID)
                .setSmallIcon(android.R.drawable.sym_def_app_icon)
                .build();

        NotificationManager notificationManager=(NotificationManager) getSystemService(this.NOTIFICATION_SERVICE);
        notificationManager.createNotificationChannel(notificationChannel);
        notificationManager.notify(1,notification);


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

    private void sendSMS(){
        for (int i = 0; i < phones.size(); i++) {
            SmsManager mySmsManager = SmsManager.getDefault();
            try {
                mySmsManager.sendTextMessage(phones.get(i),null, "Olá"+phones.get(i), null, null);
                toastCreate("Mensagem Enviada com sucesso");
            } catch (Exception e) {
                toastCreate(e.toString());
            }

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
