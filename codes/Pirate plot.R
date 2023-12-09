require(yarrr)

yarrr::pirateplot(weight ~ Diet, 
           data = ChickWeight, 
           main = "Pirate plot", 
           inf.method = "ci", 
           theme = 2,   # change theme, from 1 to 4
           pal = "decision", # use piratepal(palette = "all") to check available palettes 
           bar.f.o = 0.2)
