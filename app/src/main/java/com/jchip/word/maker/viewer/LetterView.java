package com.jchip.word.maker.viewer;

import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.graphics.Point;
import android.graphics.Typeface;
import android.util.DisplayMetrics;
import android.util.Log;
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

        int size = this.getSize();
        this.sparkButton.getLayoutParams().width = size;
        this.sparkButton.getLayoutParams().height = size;
        this.sparkButton.setIconSize(this.dpToPx(100));
        this.sparkButton.setAnimationSpeed(1.5f);

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
                //sparkButton.setScaleX(1.2f);
                //sparkButton.setScaleY(1.2f);
                action.onAction(index, letter);
            }
        });
    }

    public void setViewEnable(boolean enable) {
        this.sparkButton.setEnabled(enable);
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

    public float pxToDp(int px) {
        return px / ((float) this.activity.getResources().getDisplayMetrics().densityDpi / DisplayMetrics.DENSITY_DEFAULT);
    }

    public int dpToPx(float dp) {
        return (int) (dp * ((float) this.activity.getResources().getDisplayMetrics().densityDpi / DisplayMetrics.DENSITY_DEFAULT));
    }

    private int getSize() {
        DisplayMetrics displayMetrics = new DisplayMetrics();
        this.activity.getWindowManager().getDefaultDisplay().getMetrics(displayMetrics);
        int size = Math.min(displayMetrics.widthPixels, displayMetrics.heightPixels);

        Log.d("", "button size =" + (this.pxToDp(size / 3)));
        return Math.min(size / 3, this.dpToPx(120f));
    }
}