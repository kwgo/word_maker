package com.jchip.word.maker;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.util.Log;

import com.jchip.word.maker.spark.SparkButton;
import com.jchip.word.maker.viewer.WordView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);


        WordView WordView = new WordView(this, "3456789", this::onAction);
    }

    private void onAction(int index, String number) {
        Log.d("X", "number=" + number);
    }
}