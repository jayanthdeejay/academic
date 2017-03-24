(ns clojure-noob.core
  (:gen-class))

(defn -main
  "I don't do a whole lot ... yet."
  [& args]
  (println "Hello, World!")
  (println "Hello asshole!"))

(println "C-x C-e prints this line!")
(println "(this line is inside parentheses)")

(defn blank? [str]
(every? #(Character/isWhitespace %) str))

;Quicksort implementation -- found online!
(defn qsort [L]
  (if (empty? L) 
      '()
      (let [[pivot & L2] L]
           (lazy-cat (qsort (for [y L2 :when (<  y pivot)] y))
                     (list pivot)
                     (qsort (for [y L2 :when (>= y pivot)] y)))))) 

;Not sure what format is doing. I guess, it associates %s with username!
(defn helloworld [username]
  (println (format "Hello, %s" username)))



(defn hello
  "This is my first doc string made available to a simple function which takes one argument and prints Hello followed by the argument"
  [name]
  (str "Hello, " name))


((fn [x] (* x x)) 12)

(defn triple [x] (* x 3))

(cond
 (< 5 3) (println "Yes!")
 (< 5 7) (println "No!!")
 :else (println "Meh!!"))


(defn first-double
  [s]
  (cond
   (< (count s) 2) nil 
   (= (first s) (second s)) (first s) 
   :else (first-double1 (rest s))
   )
)
