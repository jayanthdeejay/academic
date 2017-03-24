(ns ucycles.core)

;;def LengthLimitedLyndonWords(s,n):
;;    w = [-1]
;;    while w:
;;        w[-1] += 1
;;        yield w
;;        m = len(w)
;;        while len(w) < n:
;;            w.append(w[-m])
;;        while w and w[-1] == s - 1:
;;            w.pop()


;;def DeBruijnSequence(s,n):
;;    output = []
;;    for w in LengthLimitedLyndonWords(s,n):
;;        if n % len(w) == 0:
;;            output += w
;;    return output





(defn inc-last-elmnt 
  [w] 
  (conj (into [] (drop-last 1 w)) (inc (last w))))

(defn appnd-last [w] (conj w (last w)))

(defn appnd
  [w n]
  (reduce conj w (into [] (take (- n (count w)) (repeat (first w))))))

(defn pop-last
  [w]
  (into [] (butlast w)))

(defn mypop
  [w s]
  (if (and (> (count w) 0) (= (last w) (- s 1)))
    (do (print w) (recur (into [] (butlast w)) s))
    w))
