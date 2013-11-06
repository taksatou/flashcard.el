;;; flashcard.el --- Flashcard generator for Emacs.

;; Copyright (C) 2013 Takayuki Sato

;; Author: Takayuki Sato
;; Created: 5 November 2013
;; Keywords: convenience, education
;; Version: 0.1.0
;; URL: https://github.com/taksatou/flashcard.el
;; Package-Requires: ((yaml-mode "0.0.9"))

;;; Commentary:
;;
;; flashcard.el provides trivial functions to support making flashcard for learning.
;; flashcard.el stores all cards as an yaml file, you can easily export the file in
;; arbitrary format and then import it into your favorite tool, for example `Anki`.
;;
;;; Usage
;; put flashcard.el to load path, and add following code to your .emacs
;;
;; (require 'flashcard)
;; (setq flashcard-file-path "/path/to/flashcard")  ;; default value is $HOME/.flashcard.yaml
;; (define-key global-map "C-c C-; C-c" 'flashcard-new-card)
;; (define-key flashcard-minor-mode-map "C-c C-c" 'flashcard-append-card)
;;

(require 'yaml-mode)

(defvar flashcard-file-path (format "%s/.flashcard.yaml" (getenv "HOME"))
  "Path to flashcard file.")

(defvar flashcard-template "\
*TitleHere*:
  pronunciation:
  category:
  definition:
  note:
--
"
  "Flashcard template.")

(defun flashcard-init-minor-keymap ()
  "Set up the `flashcard-minor-mode' keymap."
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c C-c") 'flashcard-append-card)
    map))

(defvar flashcard-minor-mode-map (flashcard-init-minor-keymap)
  "The keymap used when `flashcard-minor-mode' is active.")

(define-minor-mode flashcard-minor-mode
  "Flashcard minodr mode

Key bindings:
\\{flashcard-minor-mode-map}"
  nil
  " flashcard"
  :group 'flashcard
  )

(defun flashcard-append-card ()
  "Append new card to flashcard file."
  (interactive)
  (write-region nil nil flashcard-file-path t)
  (kill-buffer (current-buffer)))

(defun flashcard-new-card ()
  "Pops a new buffer for a new card."
  (interactive)
  (switch-to-buffer "*new card*")
  (erase-buffer)
  (insert flashcard-template)
  (beginning-of-buffer)
  (move-beginning-of-line nil)
  (yaml-mode)
  (flashcard-minor-mode))

(provide 'flashcard)
;;; flashcard.el ends here

