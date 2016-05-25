do

function run(msg, matches)
  local text = [[ [SpheroBoT](http://telegram.me/sphero)
  
*Version: 2.2*
  
_more information send 
!spherobot 
to chat_
[Developer](http://telegram.me/mrblacklife)
[Channel](http://telegram.me/spheroch)
*TNX to all*]]
send_api_msg(msg, get_receiver_api(msg), text, true, 'md')
end
return {
  description = "Shows bot version", 
  usage = "!version: Shows bot version",
  patterns = {
    "^[!/]version$",
    "^[!/]ver$",
    "^[Vv]ersion$",
    "^[Vv]er$"
  }, 
  run = run 
}

end
