save_to_csv <- function(df, path) {
  # Add logging
  if (!file.exists(path)){
    write.csv(df, path)
    message('Adding: ', df)
  } else {
    message('File already exists')
  }
}
