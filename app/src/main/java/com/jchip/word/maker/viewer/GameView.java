package com.jchip.word.maker.viewer;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.widget.TextView;

import com.jchip.word.maker.R;
import com.jchip.word.maker.ResultActivity;

public class GameView {
    private Activity activity;
    private String word = "";
    private String resultWord = "";

    public GameView(Activity activity) {
        this.activity = activity;

        WordHelper.instance().loadWords(activity);

        this.word = WordHelper.instance().getWord();
        new WordView(activity, word, this::onAction);

        TextView titleView = activity.findViewById(R.id.view_title);
        titleView.setText(this.getTitle());
    }

    private void onAction(int index, String letter) {
        Log.d("xx", "letter===" + letter);
        this.resultWord += letter;
        if (this.resultWord.length() == this.word.length()) {
            Intent intent = new Intent(activity, ResultActivity.class);
            //        Intent intent = new Intent(getApplicationContext(), ResultActivity.class);
            intent.putExtra("word", this.word);
            intent.putExtra("resultWord", this.resultWord);
            Log.d("word", "save word===" + word);
            this.activity.startActivity(intent);
        }
    }

    private String getTitle() {
        StringBuilder title = new StringBuilder();
        title.append(WordHelper.instance().getBookIndex() + 3);
        title.append(" Letters   ");
        title.append(WordHelper.instance().getWordIndex() + 1);
        title.append("/");
        title.append(WordHelper.instance().getWordCount() + 0);
        return title.toString();
    }
}
