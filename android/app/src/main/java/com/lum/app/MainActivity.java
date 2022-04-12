package com.lum.app;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.annotation.RequiresApi;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private Intent forService;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(getFlutterEngine());

        forService = new Intent(this, VolumeBackgroundService.class);

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(),"com.lum.volume").setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
                if(call.method.equals("startService")){
                    start();
                    result.success("volume init ");
                }
            }
        });
    }

    private void start(){
        startService(forService);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        stopService(forService);
    }
}
