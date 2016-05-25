local function run(msg)
if msg.text == "GroupTimeEnd!:free" and is_admin(msg) then 
return "!rem"
end
end 
return { 
 patterns = {
 "^GroupTimeEnd!:free$",
},
 run = run, 
pre_process = pre_process
}
