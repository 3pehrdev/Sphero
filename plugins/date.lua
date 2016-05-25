function run(msg, matches)
text = io.popen("cal"):read('*all')
  return text
end
return {
description = " show date ",
usage = {
"!date : show date",
},
  patterns = {
    '^[/!#][Dd]ate$',
  },
  run = run,
  moderated = true
}
