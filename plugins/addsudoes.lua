do
local function callback(extra, success, result)
vardump(success)
vardump(result)
end
local function run(msg, matches)
local sudo = 85831686 --Put you id Here !
local addsudo = 'user#id'..sudo
local chat = get_receiver(msg)
if is_momod(msg) then -- you can set it to is_owner(msg)
chat_add_user(chat, addsudo, callback, false)
end
end
return {
description = "Add my sudo with you",
usage = {
user = {
" List Help For Sphero-Bot:",
"Developed by : @Joker_admin_1",
},
moderator = {
"!addsudo : invite Sudo to your group" },
},
patterns ={
"^[~!/][Aa][Dd][Dd][Ss][uU][Dd][oO]$",
"^[Aa][Dd][Dd][Ss][uU][Dd][oO]$",
"^[~!/][Aa][Dd][Dd][Aa][Dd][Mm][Ii][Nn]$",
"^[Aa][Dd][Dd][Aa][Dd][Mm][Ii][Nn]$",
},
run = run
}
end

-- a
