library(plotly)

mydata <- data.frame(
  parameters = c("Peak Amplitude", "Peak Count", "Peak Rate",
                 "Peak Spacing", "Peak Width 50%", "Peak Width 90%",
                 "Peak Rise Time", "Peak Decay Time",
                 "Rise Slope", "Decay Slope"),
  Wt_DMSO = rep(100, 10),
  APOE_DMSO = c(127.07127, 54.20589, 53.3881, 200.15486, 174.3263,
                148.8633, 136.1452, 116.2678, 103.59806, 116.50617),
  ten_uM_Donepezil = c(75.49221, 141.10778, 146.3203, 64.33077, 157.0577,
                       116.4687, 129.5369, 101.4318, 56.01559, 77.95287))

p <- plot_ly(
  type = "scatterpolar",
  fill = "toself",
  mode = "lines")

p1 <- p %>%
  add_trace(
    r = mydata$Wt_DMSO,
    theta = mydata$parameters,
    name = "Wt_DMSO",
    fillcolor = rgb(8, 9, 9, 50, maxColorValue = 255),
    line = list(color = rgb(8, 9, 9, maxColorValue = 255), width = 1.5)
  ) %>%
  add_trace(
    r = mydata$APOE_DMSO,
    theta = mydata$parameters,
    name = "APOE_DMSO",
    fillcolor = rgb(255, 135, 135, 200, maxColorValue = 255),
    line = list(color = rgb(255, 135, 135, 200, maxColorValue = 255), width = 1)
  ) %>%
  add_trace(
    r = mydata$ten_uM_Donepezil,
    theta = mydata$parameters,
    name = "10 uM Donepezil",
    fillcolor = rgb(166, 197, 193, 150, maxColorValue = 255),
    line = list(color = rgb(166, 197, 193, 150, maxColorValue = 255),
                width = 1)
  ) %>%
  layout(
    polar = list(
      radialaxis = list(
        visible = TRUE,
        range = c(0,300),
        tickvals = seq(0, 300, 50),
        tickangle = 90)),
    legend = list(
      orientation = "v",
      x = 0.4,
      y = - 0.2))

p1
