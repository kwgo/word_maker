package com.jchip.word.maker.viewer;

import android.content.Context;
import android.util.Log;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.List;

public class WordHelper {
    private static WordHelper wordHelper = new WordHelper();

    public static WordHelper instance() {
        return wordHelper;
    }

    List<List<String>> words;
    List<Integer> numbers;

    private int bookIndex = -1;
    private int wordIndex = 0;

    public List<String> getWords() {
        return this.words.get(this.bookIndex);
    }

    private WordHelper() {
    }


    public int getBookIndex() {
        return this.bookIndex;
    }

    public void setBookIndex(int bookIndex) {
        this.bookIndex = bookIndex;
        this.wordIndex = this.numbers.get(bookIndex);
    }


    public int getWordIndex() {
        return this.wordIndex;
    }

    public int getWordCount() {
        return this.words.get(this.bookIndex).size();
    }

    public void setNextWord() {
        this.wordIndex = this.wordIndex + 1;
        if (this.wordIndex >= this.words.get(this.bookIndex).size()) {
            this.wordIndex = this.words.get(this.bookIndex).size() - 1;
        }
        this.numbers.set(this.bookIndex, this.wordIndex);
    }

    public String getWord() {
        return this.words.get(this.bookIndex).get(this.wordIndex);
    }

    public void loadWords(Context context) {
        if (this.words == null) {
            this.words = new ArrayList<>();
            for (int index = 3; index <= 9; index++) {
                this.words.add(this.loadWords(context, index));
            }
        }
        if (this.numbers == null) {
            this.loadNumbers(context);
        }
    }

    public List<String> loadWords(Context context, int index) {
        List<String> lines = new ArrayList<>();
        try {
            int id = context.getResources().getIdentifier("word_" + index, "raw", context.getPackageName());
            InputStream file = context.getResources().openRawResource(id);
            BufferedReader reader = new BufferedReader(new InputStreamReader(file));
            while (true) {
                String line = reader.readLine();
                if (line == null) {
                    break;
                }
                lines.add(line);
            }
        } catch (Exception error) {
            Log.d("Fatal Error: ", error.toString());
        }
        return lines;
    }

    public void loadNumbers(Context context) {
        this.numbers = new ArrayList<>();
        try {
            String name = "word_number.txt";
            String path = context.getFilesDir().getAbsolutePath() + File.separator + name;
            InputStream file = new FileInputStream(path);
            BufferedReader reader = new BufferedReader(new InputStreamReader(file));
            String line;
            do {
                line = reader.readLine();
                this.numbers.add(Integer.parseInt(line));
            } while (line != null);
            reader.close();
        } catch (Exception error) {
            Log.d("Fatal Error: ", error.toString());
        }
        for (int index = this.numbers.size(); index < 9; index++) {
            this.numbers.add(0);
        }
    }

    public void saveNumbers(Context context) {
        try {
            String name = "word_number.txt";
            String path = context.getFilesDir().getAbsolutePath() + File.separator + name;
            OutputStream file = new FileOutputStream(path);
            BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(file));
            for (int number : this.numbers) {
                writer.write(String.valueOf(number));
                writer.newLine();
            }
            writer.close();
        } catch (Exception error) {
            Log.d("Fatal Error: ", error.toString());
        }
    }
}
