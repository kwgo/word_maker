package com.jchip.word.maker.viewer;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.util.TypedValue;
import android.view.View;
import android.widget.ImageView;

import androidx.core.content.res.ResourcesCompat;

import com.jchip.word.maker.R;
import com.jchip.word.maker.image.TextDrawable;
import com.jchip.word.maker.spark.SparkButton;
import com.jchip.word.maker.spark.SparkEventListener;

public class LetterView {

    private Activity activity;
    private int index;
    private String letter;
    private ActionListener action;

    private SparkButton sparkButton;

    public LetterView(Activity activity, int index, String letter, ActionListener action) {
        this.activity = activity;
        this.index = index;
        this.letter = letter;
        this.action = action;

        int id = activity.getResources().getIdentifier("view_letter_" + index, "id", activity.getPackageName());
        this.sparkButton = activity.findViewById(id);
        this.sparkButton.setVisibility(letter.trim().isEmpty() ? View.INVISIBLE : View.VISIBLE);

        this.sparkButton.setInactiveImage(this.getImageBuilder().buildRound(letter, Color.TRANSPARENT));

        this.sparkButton.setEventListener(new SparkEventListener() {
            @Override
            public void onEvent(ImageView button, boolean buttonState) {
                if (buttonState) {
                }
            }

            @Override
            public void onEventAnimationStart(ImageView button, boolean buttonState) {
                sparkButton.setEnabled(false);
            }

            @Override
            public void onEventAnimationEnd(ImageView button, boolean buttonState) {
                sparkButton.setScaleX(2);
                sparkButton.setScaleY(2);
                action.onAction(index, letter);
            }
        });
    }

    // public void setTapped(boolean tapped) {
    //      this.tapped = tapped;
    //   }

    public void setColor(int color) {
        this.sparkButton.setColors(Color.GREEN, Color.YELLOW);
        this.sparkButton.setActiveImage(this.getImageBuilder().buildRound(letter, color));
    }

    private TextDrawable.Builder getImageBuilder() {
        float sp = 60;
        float px = sp * this.activity.getResources().getDisplayMetrics().scaledDensity;
        Typeface typeface = ResourcesCompat.getFont(this.activity, R.font.aldrich);
        return (TextDrawable.Builder) TextDrawable.builder()
                .beginConfig()
                .useFont(typeface)
                .fontSize((int) px)
                .endConfig();
    }
}
