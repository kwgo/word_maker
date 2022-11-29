package com.jchip.word.maker.wear;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.widget.ImageView;
import android.widget.TextView;

import com.jchip.word.maker.spark.SparkButton;
import com.jchip.word.maker.spark.SparkEventListener;
import com.jchip.word.maker.viewer.WordView;
import com.jchip.word.maker.wear.databinding.ActivityMainBinding;

public class MainActivity extends Activity {

    private TextView mTextView;
    private ActivityMainBinding binding;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        binding = ActivityMainBinding.inflate(getLayoutInflater());
        setContentView(binding.getRoot());


        WordView WordView = new WordView(this, "3456789", this::onAction);
    }

    private void onAction(int index, String number) {
        Log.d("X", "number=" + number);
    }
}