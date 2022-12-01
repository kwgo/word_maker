package com.jchip.word.maker.wear;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

import com.jchip.word.maker.wear.databinding.ActivityHintBinding;

public class ResultActivity extends Activity {

    private TextView mTextView;
    private ActivityHintBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityHintBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());

        mTextView = binding.text;
    }
}