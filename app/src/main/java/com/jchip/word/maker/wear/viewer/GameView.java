package com.jchip.word.maker.wear.viewer;

import android.app.Activity;
import android.content.Intent;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.jchip.word.maker.wear.R;
import com.jchip.word.maker.wear.ResultActivity;

public class GameView {
    private Activity activity;
    private String word = "";
    private String resultWord = "";

    public GameView(Activity activity) {
        this.activity = activity;

        WordHelper.instance().loadWords(activity);

        this.word = WordHelper.instance().getWord();
        new WordView(activity, word, 25, this::onAction);

        View nameView = activity.findViewById(R.id.view_name);
        nameView.setOnClickListener((v) -> onHint());
        TextView titleView = activity.findViewById(R.id.view_title);
        titleView.setText(this.getTitle());
        titleView.setOnClickListener((v) -> onHint());
        ImageView hintView = activity.findViewById(R.id.view_hint);
        hintView.setOnClickListener((v) -> onHint());
    }

    private String getTitle() {
        StringBuilder title = new StringBuilder();
        title.append(WordHelper.instance().getBookIndex() + 3);
        title.append(" Letters - ");
        title.append(WordHelper.instance().getWordIndex() + 1);
        title.append("/");
        title.append(WordHelper.instance().getWordCount() + 0);
        return title.toString();
    }

    private void onAction(int index, String letter) {
        this.resultWord += letter;
        if (this.resultWord.length() == this.word.length()) {
            Intent intent = new Intent(activity, ResultActivity.class);
            intent.putExtra("word", this.word);
            intent.putExtra("resultWord", this.resultWord);
            this.activity.startActivity(intent);
        }
    }

    private void onHint() {
        Intent intent = new Intent(activity, ResultActivity.class);
        intent.putExtra("word", this.word);
        intent.putExtra("resultWord", "[HINT]");
        this.activity.startActivity(intent);
    }
}
