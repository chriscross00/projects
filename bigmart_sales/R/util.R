save_to_csv <- function(df, path) {
  if (!file.exists(path)) {
    write.csv(df, path, row.names = FALSE)
    loginfo('Saving df to %s', path)
    message('Adding: ', df)
  } else {
    message('File already exists')
  }
}

save_to_png <- function(fig, path) {
  if (!file.exists(path)) {
    ggsave(path)
    message('Adding: ', fig)
    loginfo('Saving fig to %s', path)
  } else {
    message('Figure already exists')
  }
}
