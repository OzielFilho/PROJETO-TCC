package com.lum.app;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;

import android.support.v4.media.session.MediaSessionCompat;
import android.support.v4.media.session.PlaybackStateCompat;
import android.util.Log;

import androidx.annotation.Nullable;
import androidx.media.VolumeProviderCompat;

import java.util.ArrayList;
import java.util.List;


public class VolumeBackgroundService extends Service {
    private static MediaSessionCompat mediaSession;
    private static List<Integer> directionList = new ArrayList<Integer>();


    @Override
    public void onCreate() {
        super.onCreate();
        mediaSession = new MediaSessionCompat(this, "VolumeBackgroundService");
        execute();
    }

    private void execute(){
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
                            if(directionList.size() == 3){
                                Log.d("","-------------FINISH-------------");
                                directionList.clear();
                            }
                        }
                    }
                };

        mediaSession.setPlaybackToRemote(myVolumeProvider);
        mediaSession.setActive(true);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        mediaSession.release();
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}

