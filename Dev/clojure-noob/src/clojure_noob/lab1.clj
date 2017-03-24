

(defn hello 
  [name]
  (str "Hello " name))


(defn collatz
  [n]
  (print n " ")
  (cond 
   (= n 1) 1
   (even? n) (collatz (/ n 2))
   :else (collatz (inc (* 3 n)))))


(defn crazy 
    ([x y & z] (println x "\n" y "\n" z ) (+ x y (apply + z)))
    ([x y] (println x "\n" y) (+ x y))
    ([x] x))

(do 
  (println (+ 1 2 3 4))
  (println (* 1 2 3 4))
  (println (/ 22.0 7))
  "Nothing")


(let 
    [pi 3.142857
     r  12
     r_square (* r r)]
  (println "Radius: " r)
  (* r_square pi))


(defn print_down 
  [n]
  (when (pos? n)
    (println n)
    (recur (dec n))))



(defn fact 
  [pro n]
  (if (> n 0)
    (recur (* pro n) (dec n)) pro))



(spit "fact.txt" (fact 1M 1000000))
