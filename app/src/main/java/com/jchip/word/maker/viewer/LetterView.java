package com.jchip.word.maker.viewer;

import android.app.Activity;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;

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


    private boolean tapped;
    private int color;
    private double size;

    public LetterView(Activity activity, int index, String letter, ActionListener action) {
        this.activity = activity;
        this.index = index;
        this.letter = letter;
        this.action = action;

        int id = activity.getResources().getIdentifier("view_letter_" + index, "id", activity.getPackageName());
        this.sparkButton = activity.findViewById(id);

        Drawable inactiveDrawable = TextDrawable.builder().buildRound(letter, Color.LTGRAY);
        this.sparkButton.setInactiveImage(inactiveDrawable);

        //this.sparkButton.setColors(Color.GREEN, Color.CYAN);

        this.sparkButton.setEventListener(new SparkEventListener(){
            @Override
            public void onEvent(ImageView button, boolean buttonState) {
                if (buttonState) {
                    sparkButton.setScaleX(2);
                    sparkButton.setScaleY(2);
                }
            }
            @Override
            public void onEventAnimationStart(ImageView button, boolean buttonState) {
                sparkButton.setEnabled(false);
            }
            @Override
            public void onEventAnimationEnd(ImageView button, boolean buttonState) {
                action.onAction(index, letter);
            }
        });
    }

    public void setTapped(boolean tapped) {
        this.tapped = tapped;
    }

    public void setColor(int color) {
        this.color = color;
        this.sparkButton.setColors(Color.GREEN, Color.YELLOW);

        Drawable activeDrawable = TextDrawable.builder().buildRound(letter, color);
        this.sparkButton.setActiveImage(activeDrawable);
    }

    public void setSize(double size) {
        this.size = size;
    }

}
