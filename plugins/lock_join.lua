kicktable = {}


local function run(msg, matches)
    if is_momod(msg) then
        return msg
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['lock_join'] then
                lock_member = data[tostring(msg.to.id)]['settings']['lock_join']
            end
        end
    end
    local chat = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if lock_join == "yes" then
      send_large_msg(get_receiver(msg), "User @" .. msg.from.username .. " member add is lock!")
      chat_del_user(chat, user, ok_cb, true)
    end
end
 
return {
description = "lockjoin",
usage = {
moderator = {
"!<lock/unlock> join : to lock or unlock join our group" },
},
  patterns = {
  "^!!tgservice (chat_add_user_link)$"
 },
  run = run
}
