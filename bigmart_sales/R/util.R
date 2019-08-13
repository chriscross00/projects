save_to_csv <- function(df, path) {
  # Add logging
  if (!file.exists(path)) {
    write.csv(df, path, row.names = FALSE)
    message('Adding: ', df)
  } else {
    message('File already exists')
  }
}

save_to_png <- function(fig, path) {
  # add logging
  if (!file.exists(path)) {
    ggsave(path)
    message('Adding: ', fig)
  } else {
    message('Figure already exists')
  }
}
