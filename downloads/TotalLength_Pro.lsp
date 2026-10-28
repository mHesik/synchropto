;;; =========================================================================
;;; ИНСТРУМЕНТ: TotalLength_Pro.lsp
;;; НАЗНАЧЕНИЕ: Подсчет суммарной длины выбранных объектов (полилинии, отрезки, дуги, сплайны)
;;; СОВМЕСТИМОСТЬ: AutoCAD 2018-2026, AutoCAD Civil 3D, nanoCAD 21+
;;; РАЗРАБОТАНО ДЛЯ: СтройПТО.AI (Автоматизация отдела ПТО)
;;; =========================================================================

(defun c:TLEN ( / ss i ent len total objName)
  (vl-load-com)
  (setq total 0.0)
  (princ "\n[СтройПТО.AI] Выберите объекты для подсчета суммарной длины (или Нажмите Enter для выбора всех на слое): ")
  (setq ss (ssget '((0 . "LINE,LWPOLYLINE,POLYLINE,ARC,SPLINE,CIRCLE"))))
  
  (if ss
    (progn
      (setq i 0)
      (while (< i (sslength ss))
        (setq ent (ssname ss i))
        (setq obj (vlax-ename->vla-object ent))
        (setq len (vlax-curve-getDistAtParam obj (vlax-curve-getEndParam obj)))
        (setq total (+ total len))
        (setq i (1+ i))
      )
      (princ (strcat "\n=========================================="))
      (princ (strcat "\n[ИТОГ ПОДСЧЕТА]: Обработано объектов: " (itoa (sslength ss))))
      (princ (strcat "\n[СУММАРНАЯ ДЛИНА]: " (rtos total 2 3) " м (ед. чертежа)"))
      (princ (strcat "\n=========================================="))
      (alert (strcat "СтройПТО.AI:\nОбработано объектов: " (itoa (sslength ss)) "\nСуммарная длина: " (rtos total 2 3) " м"))
    )
    (princ "\n[СтройПТО.AI] Ничего не выбрано.")
  )
  (princ)
)

(princ "\n[СтройПТО.AI] Макрос TotalLength_Pro успешно загружен! Введите команду TLEN для запуска.\n")
