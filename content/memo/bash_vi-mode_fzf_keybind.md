---
title: Bashをviモードで使う際のfzfキーバインド
description:
date: 2025-07-31
---

## Bash(readline)のviモード

自分はBashをviモードで使用しています。

```readline
set editing-mode vi
set show-mode-in-prompt on
set vi-cmd-mode-string "\1\e[2 q\2"
set vi-ins-mode-string "\1\e[6 q\2"

$if mode=vi
    set keymap vi-insert
        Control-l: clear-screen
$endif
```

テキストオブジェクトなど使用できない機能はたくさんありますが`cc`での行削除や`jk`での履歴移動はとても便利です。

カーソルの形状で自分がどのモードにいるかも判別できます。

![demo_vi-mode.gif](https://r2.hashitaku.dev/demo_vi-mode.gif)

## fzf

`jk`での履歴移動は便利ですが履歴を検索したいこともあります。

`readline`の`reverse-search-history`で履歴検索をすることも可能ですがリッチなUIがほしいのと、あいまい検索ができるため`fzf`を使用しています。

`.bashrc`の中で`fzf`のセットアップを行っています。

```bash
type fzf >/dev/null 2>&1 && eval "$(fzf --bash)"
```

`fzf --bash`を読み込むことでいくつかのキーバインドと関数が追加されます。

## 意図しないタイミングで`__fzf_cd__`が起動してしまう現象が発生

`echo Hello World`と入力後に`Ctrl-[`でノーマルモードへ移動、`cc`で行を削除を行うつもりが`__fzf_cd__`が起動してしまいます。

`cc`の`c`を入力した時点で`__fzf_cd__`が起動し検索欄に`c`が入力されます。

![normal_fzf-cd.gif](https://r2.hashitaku.dev/normal_fzf-cd.gif)

上のgifを生成した`vhs`

```vhs
Output demo.gif

Require echo
Require fzf

Set Shell "bash"
Set FontSize 32
Set Width 800
Set Height 600
Set TypingSpeed 50ms

Hide
Type `eval "$(fzf --bash)"`
Enter
Show

Type "echo Hello World"

Sleep 1s

Ctrl+[
Sleep 100ms
Type "cc"

Sleep 3s
```

`Ctrl+[`の直後にある`Sleep 100ms`を`500ms`以上にすると想定した動作になります。

![normal_cc.gif](https://r2.hashitaku.dev/normal_cc.gif)

## 原因

`fzf --bash`を読み込んで追加されるキーバインドの一つに`Alt-c`で`__fzf_cd__`を呼び出すものがあります。

```bash
bind -m emacs-standard '"\ec": " \C-b\C-k \C-u`__fzf_cd__`\e\C-e\er\C-m\C-y\C-h\e \C-y\ey\C-x\C-x\C-d"'
bind -m vi-command '"\ec": "\C-z\ec\C-z"'
bind -m vi-insert '"\ec": "\C-z\ec\C-z"'
```

`bind -XS`でbashにどのようなキーバインドが追加されているかを調べることができます。

`Alt-c`は`ESC-c`と同じキーコードを送信するものであるため、それと同様のキーコードを送信する`Ctrl-[c`に反応していたようです。

`od`で実際に`Alt-c`と`Ctrl-[c`が同じであることが確かめることもできます。

```bash
od -Ax -tx1a
000000  1b  63  1b  63
       esc   c esc   c
```

## 解決方法

`fzf`のセットアップを行った後に`\ec`のキーバインドを削除しています。

そもそも`fzf`でディレクトリを移動したいことがないためあまり不便には感じていませんが今後別の方法を取ることもあり得ます。

```bash
type fzf >/dev/null 2>&1 && eval "$(fzf --bash)" && bind -r '\ec'
```

別の解決方法としてreadlineの設定で`keyseq-timeout`を小さな値にする方法があります。

デフォルトで500ms待つためもう少し短くしても良いかもしれません。

## 参考

[端末アプリで Ctrl-\[ が Esc になる理由](https://tyru.hatenablog.com/entry/2018/10/04/151740)

[vi キーバインドで、なぜ J が下で K が上なのか？ ](https://blog.shinonome.io/vi-hjkl-with-ascii/)
