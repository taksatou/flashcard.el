# flashcard.el

Flashcard maker for Emacs.

`flashcard.el` provides trivial functions to support making flashcard for learning.
`flashcard.el` stores all cards as an yaml file, so you can easily export the file in arbitrary format and then import it into your favorite tool, like `Anki`.

# usage

put flashcard.el to load path, and add following code to your .emacs

```
(require 'flashcard)
(setq flashcard-file-path "/path/to/flashcard")  ;; default value is $HOME/.flashcard.yaml
(define-key global-map "C-c C-; C-c" 'flashcard-new-card)
(define-key flashcard-minor-mode-map "C-c C-c" 'flashcard-append-card)
```

# utilities

`to_anki.rb` allows you to convert flashcard file into `Anki` format.

```
ruby scripts/to_anki.rb < ~/.flashcard.yaml > anki.csv
```

see also, http://ankisrs.net/docs/manual.html#importing
