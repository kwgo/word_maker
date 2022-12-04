package com.jchip.word.maker.wear;

import android.app.Activity;
import android.os.Bundle;

import androidx.core.content.res.ResourcesCompat;

import com.jchip.word.maker.wear.databinding.ActivityMainBinding;
import com.jchip.word.maker.wear.viewer.MainView;

public class MainActivity extends Activity {
    private ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        new MainView(this);
    }

    @Override
    public void onBackPressed() {
        moveTaskToBack(true);
    }
}