package com.jchip.word.maker;

import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import com.jchip.word.maker.viewer.MainView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        new MainView(this);
    }

    @Override
    public void onBackPressed() {
        moveTaskToBack(true);
    }
}