package com.jchip.word.maker.wear;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

import com.jchip.word.maker.wear.databinding.ActivityResultBinding;
import com.jchip.word.maker.wear.viewer.ResultView;

public class ResultActivity extends Activity {
    private ActivityResultBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityResultBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        new ResultView(this);
    }

    @Override
    public void onBackPressed() {
        this.startActivity(new Intent(this, GameActivity.class));
    }
}