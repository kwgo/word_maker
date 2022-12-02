package com.jchip.word.maker.viewer;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.Typeface;
import android.view.View;
import android.widget.ImageView;

import androidx.core.content.res.ResourcesCompat;

import com.jchip.word.maker.R;
import com.jchip.word.maker.image.TextDrawable;
import com.jchip.word.maker.spark.SparkButton;
import com.jchip.word.maker.spark.SparkEventListener;

public class LetterView {
    private Activity activity;
    private String letter;
    private float fontSize = 60;

    private SparkButton sparkButton;

    public LetterView(Activity activity, int index, String letter, float fontSize, ActionListener action) {
        this.activity = activity;
        this.letter = letter;
        this.fontSize = fontSize;

        int id = activity.getResources().getIdentifier("view_letter_" + index, "id", activity.getPackageName());
        this.sparkButton = activity.findViewById(id);
        this.sparkButton.setInactiveImage(this.getImageBuilder().buildRound(letter, Color.TRANSPARENT));
        this.sparkButton.setVisibility(letter.trim().isEmpty() ? View.INVISIBLE : View.VISIBLE);

        int size = this.spToPx(90);
        this.sparkButton.getLayoutParams().width = size;
        this.sparkButton.getLayoutParams().height = size;
        this.sparkButton.setIconSize(size / 2);

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
                sparkButton.setScaleX(1.2f);
                sparkButton.setScaleY(1.2f);
                action.onAction(index, letter);
            }
        });
    }

    public void setColor(int color) {
        this.sparkButton.setColors(Color.GREEN, Color.YELLOW);
        this.sparkButton.setActiveImage(this.getImageBuilder().buildRound(letter, color));
    }

    private TextDrawable.Builder getImageBuilder() {
        Typeface typeface = ResourcesCompat.getFont(this.activity, R.font.aldrich);
        return (TextDrawable.Builder) TextDrawable.builder()
                .beginConfig()
                .useFont(typeface)
                .fontSize(this.spToPx(this.fontSize))
                .endConfig();
    }

    private int spToPx(float sp) {
        return (int) (sp * this.activity.getResources().getDisplayMetrics().scaledDensity);
    }
}