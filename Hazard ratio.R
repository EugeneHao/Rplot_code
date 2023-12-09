cox_model <- coxph(Surv(time, status) ~ sex + ph.ecog, data = lung)
ggforest(cox_model)
