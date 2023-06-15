;; Author: Philipp Kapinos
;; Version: 0.0.1

(defun generate-org-ids-in-folder-and-subfolder (folder-path)
  (interactive "Directory entrypoint: ")
  (dolist (entry (directory-files-and-attributes folder-path t "\\`[^.]")) ;;exclude folders starting with .
    (let ((file (car entry))
          (is-dir (car (cdr entry))))
      (unless (or (equal (file-name-nondirectory file) ".") ;;there should be none
                  (equal (file-name-nondirectory file) "..")
                  (and is-dir (file-symlink-p file)))
        (if is-dir
            (generate-org-ids-in-folder-and-subfolder file)
          (when (string-match "\\.org$" file)
            (find-file file)
            (org-id-get-create)
            (save-buffer)
            (kill-buffer)))))))