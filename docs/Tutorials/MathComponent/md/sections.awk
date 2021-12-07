#!/usr/bin/env awk -f

BEGIN {
  MAX_LEVELS = 10
  in_code = 0
}

$1 ~ "^```" { in_code = !in_code }

/^#+ / && !in_code {
  new_level = length($1)
  ++levels[new_level]
  for (i = new_level + 1; i <= MAX_LEVELS; ++i) 
    levels[i] = 0
  printf("%s ", $1)
  for (i = 1; i <= new_level; ++i) {
    printf("%d.", levels[i])
  }
  line = $0
  sub(/^#+ +/, "", line)
  printf(" %s\n", line)
  next
}

{ print }
