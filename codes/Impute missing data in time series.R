library(imputeTS)
data_imputation <- na_interpolation(tsAirgap, option = "linear")    
# linear interpolation; we can also try spline, stine
ggplot_na_imputations(tsAirgap, data_imputation, tsAirgapComplete)