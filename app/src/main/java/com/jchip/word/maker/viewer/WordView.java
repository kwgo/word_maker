package com.jchip.word.maker.viewer;

import android.app.Activity;
import android.graphics.Color;
import android.util.Log;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class WordView {
    private Activity activity;
    private String word;
    private double size = 60;
    private ActionListener action;

    private LetterView[] letterViews = new LetterView[9];


    private int[] colors = {
            Color.RED, Color.DKGRAY, Color.YELLOW, Color.GREEN, Color.CYAN, Color.BLUE, Color.DKGRAY, Color.BLACK, Color.LTGRAY
    };

    private int colorIndex = 0;

    public WordView(Activity activity, String word, ActionListener action) {
        this.activity = activity;
        this.word = word;
        this.action = action;

        List<String> letters = this.getLetters();
        for (int index = 0; index < letterViews.length; index++) {
            letterViews[index] = new LetterView(activity, index, letters.get(index), this::onAction);
            letterViews[index].setColor(this.colors[this.colorIndex]);
        }
    }

    private List<String> getLetters() {
        List<String> letters = Arrays.asList(new String[]{"", "", "", "", "", "", "", "", ""});
        for (int index = 0; index < this.word.length(); index++) {
            letters.set(index, String.valueOf(this.word.charAt(index)));
        }
        Collections.shuffle(letters);
        return letters;
    }

    private void onAction(int index, String letter) {
        Log.d("X", "letter=" + letter);

        if (!letter.trim().isEmpty()) {
            this.colorIndex = (this.colorIndex + 1) % 9;
            for (int offset = index + 1; offset < 9; offset++) {
                this.letterViews[index].setColor(this.colors[this.colorIndex]);
                this.letterViews[index].setSize(this.size);
            }
            this.action.onAction(index, letter);
        }
    }
}
