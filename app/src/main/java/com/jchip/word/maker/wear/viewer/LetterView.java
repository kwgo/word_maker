package com.jchip.word.maker.wear.viewer;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.Typeface;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;

import androidx.core.content.res.ResourcesCompat;

import com.jchip.word.maker.wear.R;
import com.jchip.word.maker.wear.image.TextDrawable;
import com.jchip.word.maker.wear.spark.SparkButton;
import com.jchip.word.maker.wear.spark.SparkEventListener;

public class LetterView {
    private Activity activity;
    private String letter;
    private int index;
    private float fontSize;
    private ActionListener action;

    private static int[] colors = {
            Color.RED, Color.parseColor("#ED7014"), Color.YELLOW,
            Color.GREEN, Color.CYAN, Color.BLUE,
            Color.parseColor("#E11584"), Color.parseColor("#80471C"), Color.parseColor("#A32CC4")
    };

    private SparkButton sparkButton;

    public LetterView(Activity activity, int index, String letter, float fontSize, ActionListener action) {
        this.activity = activity;
        this.letter = letter;
        this.index = index;
        this.fontSize = fontSize;
        this.action = action;

        int id = activity.getResources().getIdentifier("view_letter_" + index, "id", activity.getPackageName());
        this.sparkButton = activity.findViewById(id);

        int size = this.getSize();
        this.sparkButton.getLayoutParams().width = size;
        this.sparkButton.getLayoutParams().height = size;
        this.sparkButton.setIconSize(this.dpToPx(100));
        this.sparkButton.setAnimationSpeed(2.5f);
        this.sparkButton.setColors(Color.GREEN, Color.YELLOW);

        this.sparkButton.setInactiveImage(this.getImageBuilder().buildRound(letter, Color.TRANSPARENT));
        this.sparkButton.setVisibility(letter.trim().isEmpty() ? View.INVISIBLE : View.VISIBLE);

        this.sparkButton.setEventListener(this.viewListener);

        this.setColor(0);
    }

    private SparkEventListener viewListener = new SparkEventListener() {
        @Override
        public void onEvent(ImageView button, boolean buttonState) {
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
    };

    public void setViewEnable(boolean enable) {
        this.sparkButton.setEnabled(enable);
    }

    public void setColor(int colorIndex) {
        this.sparkButton.setActiveImage(this.getImageBuilder().buildRound(letter, LetterView.colors[colorIndex]));
    }

    private TextDrawable.Builder getImageBuilder() {
        //Typeface typeface = Typeface.createFromAsset(this.activity.getAssets(), "aldrich.ttf");
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
        return Math.min((int)((float) size / 4.0), this.dpToPx(120f));
    }
}