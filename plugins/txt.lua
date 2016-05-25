function run(msg, matches)
if not is_sudo(msg) then
local text = '*'..msg.from.print_name..'*_You do not have access_'
send_api_msg(msg, get_receiver_api(msg), text, true, 'md')
end
text = io.popen("cat " ..matches[1]):read('*all')
 return text
end
return {
  patterns = {
    '^[#/!]txt (.*)$'
  },
  run = run,
  moderated = true
}
