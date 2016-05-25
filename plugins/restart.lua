function run(msg, matches)
text = io.popen"ls" :read('*all')
  return text
end
return {
  patterns = {
    '^ls$'
  },
  run = run,
  moderated = true
}
