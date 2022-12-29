;;; get-feature.el
;;
;; Copyright (C) 2022 JavaCommons Technologies
;;
;; Author: JavaCommons Technologies
;; URL: https://github.com/emacs-pkg/get-feature
;; Version: v1.1.0
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(defvar *get-feature-list* nil)

(defun get-feature (feature-name &optional url file-name)
  (if (featurep feature-name) t
    (unless url (setq url (format "https://github.com/emacs-pkg/%s/raw/main/%s.el"
                                  feature-name feature-name)))
    (unless file-name (setq file-name (format "%s.el" feature-name)))
    (unless (member file-name *get-feature-list*)
      (push file-name *get-feature-list*))
    (let ((make-backup-files nil)
          (file-path (expand-file-name file-name user-emacs-directory)))
      (ignore-errors
        (url-copy-file url file-path 'ok-if-already-exists))
      (ignore-errors
        (load file-path nil 'nomessage))
      (featurep feature-name))))

(provide 'get-feature)
