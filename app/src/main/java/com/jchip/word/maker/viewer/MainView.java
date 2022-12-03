package com.jchip.word.maker.viewer;

import android.app.Activity;
import android.content.Intent;
import android.view.View;
import android.view.animation.AccelerateInterpolator;
import android.view.animation.AlphaAnimation;
import android.view.animation.Animation;
import android.view.animation.AnimationSet;
import android.view.animation.DecelerateInterpolator;

import com.jchip.word.maker.GameActivity;
import com.jchip.word.maker.R;

public class MainView {
    private Activity activity;

    public MainView(Activity activity) {
        this.activity = activity;

        new WordView(activity, "3456789", 48, this::onAction);

        Animation fadeIn = new AlphaAnimation(0, 1);
        fadeIn.setInterpolator(new DecelerateInterpolator());
        fadeIn.setDuration(5000);

        View view = activity.findViewById(R.id.view_word);
        view.setAnimation(fadeIn);
    }

    private void onAction(int index, String letter) {
        //this.wordView.setViewEnable(false);

        index = Integer.parseInt(letter) - 3;

        WordHelper.instance().loadWords(this.activity);
        WordHelper.instance().setBookIndex(index);

        this.activity.startActivity(new Intent(this.activity, GameActivity.class));
    }
}
