(def nodes (range 5))

(defn empty-graph [n]
(vec (repeat n #{})))

(defn add-directed-edge [g n1 n2]
(let [n1-neighbors (g n1)]
(assoc g n1 (conj n1-neighbors n2))))

(defn add-edge [g [n1 n2]]
  (-> g
      (add-directed-edge n1 n2)
      (add-directed-edge n2 n1)))

;the random generation is easy:
(defn random-edge [n]
  (vector (rand-int n) (rand-int n)))

;(add-edge (empty-graph 5) (random-edge 5))

(defn add-rand-edge [g]
  (add-edge g (random-edge (count g))))
; A lazy sequence of an evolving random graph

(def mygraph
  (last (take 15 (iterate add-rand-edge (empty-graph 10)))))


(defn random-graph-1 [n e]
  (last (take e
              (iterate add-rand-edge (empty-graph n)))))

