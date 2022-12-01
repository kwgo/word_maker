package com.jchip.word.maker;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import com.jchip.word.maker.viewer.ResultView;

public class ResultActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_result);

        new ResultView(this);
    }
}