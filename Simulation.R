
if(!require(FNN)) install.packages("FNN",repos = "http://cran.us.r-project.org")
library("FNN")

if(!require(reshape)) install.packages("reshape",repos = "http://cran.us.r-project.org")
library("reshape")

if(!require(igraph)) install.packages("igraph",repos = "http://cran.us.r-project.org")
library("igraph")

nodes <- 100
n_rel <- runif(n = nodes, min = 0, max = 1)
n_tim <- runif(n = nodes, min = 0, max = 1)

neighbor_rel <- FNN::get.knn(data = n_rel, k = 4 )$nn.index
neighbor_rel <- as.matrix(neighbor_rel)
neighbor_rel <- as.data.frame(neighbor_rel)
neighbor_rel$id <- rownames(neighbor_rel)

neighbor_rel_melt <- reshape::melt(neighbor_rel, id.vars = c("id"))
neighbor_rel_melt <- neighbor_rel_melt[c("id", "value")]
neighbor_rel_melt$id <- as.integer(neighbor_rel_melt$id)


g <- igraph::graph.edgelist(as.matrix(neighbor_rel_melt), directed = FALSE)
plot(g)


