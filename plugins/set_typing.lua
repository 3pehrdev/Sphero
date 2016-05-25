function run(msg, matches)
local hash = 'bot:typing'
if is_admin(msg) then
if matches[1] == "typing" and matches[2] == 'yes' then
redis:set(hash, "on")
return "Typing > on"
elseif matches[1] == "typing" and matches[2] == 'no' then
redis:del(hash)
return "Typing > off"
end
end
end
return {
patterns = {
"^[#!/](typing) (yes)$",
"^[#!/](typing) (no)$",
},
run = run
}
