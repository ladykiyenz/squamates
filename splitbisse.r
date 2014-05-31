##For split BiSSE

library(diversitree)
library(ape)
data <- read.csv('/home/april/projectfiles/squamates/squam/PyronSmallParityData.csv', row.names=1)
lk <- vector(mode="list")
lkp <- vector(mode="list")
bisse_split_fits <- vector(mode="list")
stat_list <- vector(mode="list")
fit_plots <- vector(mode="list")
a<- list.files(pattern="*tre")

skinks <- mrca(pruned.tree)["Plestiodon_fasciatus", "Acontias_percivali"]
gekk <- mrca(pruned.tree)["Phelsuma_ornata", "Delma_impar"]
serp <- mrca(pruned.tree)["Nerodia_rhombifer", "Liotyphlops_albirostris"]
angui <- mrca(pruned.tree)["Varanus_indicus", "Anniella_pulchra"]
lacert <- mrca(pruned.tree)["Bipes_biporus", "Teius_teyou"]
ig <- mrca(pruned.tree)["Iguana_iguana", "Chamaeleo_zeylanicus"]

model_fit <- function(const,tree_list){
for (x in tree_list){
phy <- read.tree(x)
pruned.tree<-drop.tip(phy, setdiff(phy$tip.label, row.names(data)))
sorteddata <- data[phy$tip.label, ]
no_na <- na.omit(sorteddata)
names(no_na) <- pruned.tree$tip.label
split_func <- make.bisse.split(pruned.tree, no_na, const)
func <- make.bisse(pruned.tree, no_na)
sp <- starting.point.bisse(pruned.tree)
pars.s <- rep(sp, 2)
split_fit_bisse <- find.mle(split_func,pars.s)
fit_bisse <- find.mle(func, sp)
bisse_split_fits <- append(bisse_split_fits, split_fit_bisse)
print(anova(split_fit_bisse, fit_bisse))
print(split_fit_bisse)
print(x)
return(bisse_split_fits)
}
}

