###### ------------------------------------------------------------
###### ------------------------------------------------------------
###### NAME: Network Data Collection
###### DATE: September 2018
###### Version: 1
###### ------------------------------------------------------------
###### ------------------------------------------------------------
###### Simulation of close relationships and time-based relationships


if(!require(FNN)) install.packages("FNN",repos = "http://cran.us.r-project.org")
library("FNN")

if(!require(reshape)) install.packages("reshape",repos = "http://cran.us.r-project.org")
library("reshape")

if(!require(igraph)) install.packages("igraph",repos = "http://cran.us.r-project.org")
library("igraph")

if(!require(network)) install.packages("network",repos = "http://cran.us.r-project.org")
library("network")

if(!require(sna)) install.packages("sna",repos = "http://cran.us.r-project.org")
library("sna")
if(!require(ggnet)) devtools::install_github("briatte/ggnet")
library("ggnet")

nodes <- 1000
n_rel <- runif(n = nodes, min = 0, max = 1)
n_tim <- runif(n = nodes, min = 0, max = 1)

neighbor_rel <- FNN::get.knn(data = n_rel, k = 4 )$nn.index
neighbor_rel <- as.matrix(neighbor_rel)
neighbor_rel <- as.data.frame(neighbor_rel)
neighbor_rel$id <- rownames(neighbor_rel)

neighbor_rel_melt <- reshape::melt(neighbor_rel, id.vars = c("id"))
neighbor_rel_melt <- neighbor_rel_melt[c("id", "value")]
neighbor_rel_melt$id <- as.integer(neighbor_rel_melt$id)

net <- network::network(x = neighbor_rel_melt, directed = FALSE)
a <-   network::as.matrix.network.adjacency(x = net)


network.vertex.names(net) <- neighbor_rel$id
net$id <- neighbor_rel$id
net$deg <- sna::degree(net)

ggnet2(net, node.size = 2, edge.size = 0.5, edge.color = "gray")


