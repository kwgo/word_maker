package com.jchip.word.maker.viewer;

import android.app.Activity;

import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class WordView {
    private Activity activity;
    private String word;
    private ActionListener action;

    private LetterView[] letterViews = new LetterView[9];

    private int colorIndex = 0;

    public WordView(Activity activity, String word, float fontSize, ActionListener action) {
        this.activity = activity;
        this.word = word;
        this.action = action;

        List<String> letters = this.getLetters();
        for (int index = 0; index < letterViews.length; index++) {
            letterViews[index] = new LetterView(activity, index, letters.get(index), fontSize, this::onAction);
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
        if (!letter.trim().isEmpty()) {
            this.colorIndex = (this.colorIndex + 1) % 9;
            for (int offset = index + 1; offset < 9; offset++) {
                this.letterViews[index].setColor(this.colorIndex);
            }
            this.action.onAction(index, letter);
        }
    }

    public void setViewEnable(boolean enable) {
        for (LetterView letterView : this.letterViews) {
            letterView.setViewEnable(enable);
        }
    }
}
