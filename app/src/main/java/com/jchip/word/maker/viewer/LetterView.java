package com.jchip.word.maker.viewer;

import android.app.Activity;
import android.graphics.Color;
import android.view.View;

import com.jchip.word.maker.R;
import com.jchip.word.maker.spark.SparkButton;

public class LetterView {

    private Activity activity;
    private String letter;
    private ActionListener action;

    private SparkButton sparkButton;


    private boolean tapped;
    private int color;
    private double size;

    public LetterView(Activity activity, int index, String letter, ActionListener action) {
        this.activity = activity;
        this.letter = letter;
        this.action = action;

        int id = activity.getResources().getIdentifier("view_letter_" + index, "id", activity.getPackageName());
        this.sparkButton = activity.findViewById(id);

        this.sparkButton.setActiveImage(R.drawable.ic_thumb);
        this.sparkButton.setInactiveImage(R.drawable.ic_star_off);

        this.sparkButton.setColors(Color.RED, Color.CYAN);
    }

    public void setTapped(boolean tapped) {
        this.tapped = tapped;
    }

    public void setColor(int color) {
        this.color = color;
        this.sparkButton.setColors(Color.RED, Color.MAGENTA);
    }

    public void setSize(double size) {
        this.size = size;
    }

}
