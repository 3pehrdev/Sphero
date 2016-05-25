function run(msg, matches)
text = io.popen("date"):read('*all')
  return text
end
return {
description = " Show Time ",
usage = {
"!time : show time",
},
  patterns = {
    '^[Tt]ime$',
  },
  run = run,
  moderated = true
}
