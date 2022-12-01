package com.jchip.word.maker.viewer;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.jchip.word.maker.GameActivity;

public class MainView {
    private Activity activity;
    private String word = "";
    private String resultWord = "";

    public MainView(Activity activity) {
        this.activity = activity;

        new WordView(activity, "3456789", this::onAction);
    }

    private void onAction(int index, String letter) {
        index = Integer.parseInt(letter) - 3;

        WordHelper.instance().loadWords(this.activity);
        WordHelper.instance().setBookIndex(index);

        this.activity.startActivity(new Intent(this.activity, GameActivity.class));
    }
}
