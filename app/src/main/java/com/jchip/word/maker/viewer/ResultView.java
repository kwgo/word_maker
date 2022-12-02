
package com.jchip.word.maker.viewer;

import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.widget.ImageView;
import android.widget.TextView;

import com.jchip.word.maker.GameActivity;
import com.jchip.word.maker.R;

import java.util.List;

public class ResultView {
    private Activity activity;
    private String word;
    private String resultWord;

    private boolean success = false;

    public ResultView(Activity activity) {
        this.activity = activity;

        this.word = activity.getIntent().getStringExtra("word");
        this.resultWord = activity.getIntent().getStringExtra("resultWord");
        if (this.word == null || this.resultWord == null) {
            activity.finish();
        }
        Log.d("word", "load word===" + word);
        Log.d("word", "loas resultWord===" + resultWord);
        this.success = this.isSuccess();
        boolean hint = this.isHint();

        TextView titleView = activity.findViewById(R.id.view_title);
        titleView.setText(hint ? this.word : this.resultWord);

        ImageView returnButton = activity.findViewById(R.id.view_return);
        returnButton.setImageResource(success ? R.drawable.game_success : hint ? R.drawable.game_hint : R.drawable.game_fail);

        ImageView returnView = activity.findViewById(R.id.view_return);
        returnView.setOnClickListener((v) -> this.onContinue());
    }

    private boolean isSuccess() {
        boolean success = this.resultWord.equals(this.word);
        if (!success) {
            List<String> words = WordHelper.instance().getWords();
            for (String word : words) {
                if (word.equals(this.resultWord)) {
                    return true;
                }
            }
        }
        return success;
    }

    private boolean isHint() {
        return "[HINT]".equals(this.resultWord);
    }

    public void onContinue() {
        if(this.success) {
            WordHelper.instance().setNextWord();
            WordHelper.instance().saveNumbers(this.activity);
        }
        activity.startActivity(new Intent(activity, GameActivity.class));
    }
}
