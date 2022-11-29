package com.jchip.word.maker.wear;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;

import com.jchip.word.maker.spark.SparkButton;
import com.jchip.word.maker.viewer.WordView;
import com.jchip.word.maker.wear.databinding.ActivityGameBinding;

public class GameActivity extends Activity {

    private TextView mTextView;
    private ActivityGameBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityGameBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());


        mTextView = binding.text;
    }
}