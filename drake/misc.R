train <- rio::import("analysis/data/raw_data/time_series_375_prerpocess_en.xlsx") %>% 
  fill(PATIENT_ID, .direction = "down") %>% 
  mutate(PATIENT_ID = str_c("train_", PATIENT_ID))
test <- rio::import("analysis/data/raw_data/time_series_test_110_preprocess_en.xlsx") %>% 
  fill(PATIENT_ID, .direction = "down") %>% 
  mutate(PATIENT_ID = str_c("test_", PATIENT_ID))


list-columns df


train_df_list <-
  train %>%
  group_by(PATIENT_ID) %>%
  nest()  %>%
  mutate(data =
           map(
             .x = data,
             ~ .x %>%
               fill(everything(), .direction = "down") %>%
               summarise_all(last)
           )) %>%
  unnest()

train_df_list %>% 
  select(-c("RE_DATE", "Admission time", "Discharge time")) %>% 
  janitor::clean_names() %>% colnames() %>% clipr::write_clip()
    write_csv("~/Desktop/COVID-19-375.csv")

  
  
  
py$res %>% view()
import_feature_cols <- 
  py$import_feature %>% 
  arrange(desc(xgb)) %>% 
  head(10) %>% 
  pull(col)







