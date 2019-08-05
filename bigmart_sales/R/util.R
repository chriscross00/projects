save_to_csv <- function(df, path) {
  # Add logging
  write.csv(df, path)
  message('Adding: ', df)
}
