(defn collatz 
  [n]
  (println n)
  ((= n 1) 1)
  (if (even? n) (collatz (/ n 2)) (collatz inc (* 3 n)))
  (if (= n 1)))
