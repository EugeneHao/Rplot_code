library(networkD3)
library(htmlwidgets)

# Create a data frame for the nodes
nodes <- data.frame(name = c("Stage 1", "Stage 2", "Stage 3",
                             "Stage 1", "Stage 2", "Stage 3"))

# Create a data frame for the links (the transition matrix)
links1 <- data.frame(source = c(0, 0, 0, 1, 1, 1, 2, 2, 2),
                     target = c(3, 4, 5, 3, 4, 5, 3, 4, 5),
                     value = c(0.650, 0.305, 0.045, 0.228, 0.601, 0.170, 0.054, 0.132, 0.814),
                     color = factor(c(3, 4, 5, 3, 4, 5, 3, 4, 5))) 

# Generate the Sankey diagram
sankey1 <- sankeyNetwork(Links = links1, Nodes = nodes, Source = "source",
                         Target = "target", Value = "value", NodeID = "name",
                         LinkGroup = "color", units = "TWh", width = 600, height = 400)

# Customize node (stage) font size and node colors
sankey1_fig <- htmlwidgets::onRender(
  sankey1,
  '
  function(el) {
    // Customize font size
    d3.select(el).selectAll(".node text").style("font-size", "20px");
  
    // Customize node colors
    d3.select(el).selectAll(".node").filter(function (d) { return d.name == "Not used & No plan to use"; }).select("rect").style("fill", "#F74D31");
    d3.select(el).selectAll(".node").filter(function (d) { return d.name == "Not used & Might use it"; }).select("rect").style("fill", "#F5ED21");
    d3.select(el).selectAll(".node").filter(function (d) { return d.name == "Used the practice"; }).select("rect").style("fill", "#78F521");
    
    // Customize link colors
    var colors = ["#78F521", "#F74D31", "#F5ED21", "#F5ED21", "#F74D31", "#78F521", "#F5ED21", "#F74D31", "#78F521"];
    d3.select(el).selectAll(".link").style("stroke", function(d, i) { return colors[i]; });
  }
  '
)

sankey1_fig