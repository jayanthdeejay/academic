(defn stupefy
  ([ohSnap]
   (print "You are so smart, " ohSnap))
  ([Bill & Bong]
   (do (map stupefy Bong)
       (print "You are damn smart, " Bill))))


(defn inc-maker
  [inc-by]
  #(+ % inc-by))
(def inc3 (inc-maker 3))
(inc3 17)
