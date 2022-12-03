package com.jchip.word.maker.viewer;

import android.app.Activity;
import android.content.Intent;

import com.jchip.word.maker.GameActivity;

public class MainView {
    private Activity activity;
    private WordView wordView;
    public MainView(Activity activity) {
        this.activity = activity;

        this.wordView = new WordView(activity, "3456789", 48, this::onAction);
    }

    private void onAction(int index, String letter) {
        //this.wordView.setViewEnable(false);

        index = Integer.parseInt(letter) - 3;

        WordHelper.instance().loadWords(this.activity);
        WordHelper.instance().setBookIndex(index);

        this.activity.startActivity(new Intent(this.activity, GameActivity.class));
    }
}
