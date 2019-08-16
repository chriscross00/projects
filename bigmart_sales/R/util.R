save_to_csv <- function(df, path) {
  # Add logging
  if (!file.exists(path)) {
    write.csv(df, path, row.names = FALSE)
    loginfo('Saving df to ', path)
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
    loginfo('Saving fig to ', path)
  } else {
    message('Figure already exists')
  }
}
