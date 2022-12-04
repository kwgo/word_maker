package com.jchip.word.maker.wear;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.jchip.word.maker.wear.databinding.ActivityGameBinding;
import com.jchip.word.maker.wear.viewer.GameView;

public class GameActivity extends Activity {
    private ActivityGameBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityGameBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        new GameView(this);
    }

    @Override
    public void onBackPressed() {
        this.startActivity(new Intent(this, MainActivity.class));
    }
}