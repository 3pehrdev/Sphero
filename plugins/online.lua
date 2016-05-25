do

function run(msg, matches)
  local text = [[ [Sphero](https://telegram.me/spohero) _And_ [Helper](http://telegram.me/spherorobot) _Is Online Now!_]]
send_api_msg(msg, get_receiver_api(msg), text, true, 'md')
end
return {
  description = "Shows bot version", 
  usage = "!version: Shows bot version",
  patterns = {
    "^[Ww]ayd$",
"^[!/#][Ww]ayd$"
  }, 
  run = run 
}

end
