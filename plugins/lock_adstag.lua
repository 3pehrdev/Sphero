local function run(msg)   
    local data = load_data(_config.moderation.data)   
     if data[tostring(msg.to.id)]['settings']['lock_adstag'] == 'yes' then
if not is_momod(msg) then
    send_large_msg(get_receiver(msg), "User @" .. msg.from.username .. " AdsTag is not allowed here!")
    chat_del_user('chat#id'..msg.to.id, 'user#id'..msg.from.id, ok_cb, true)
    local msgads = 'ForbiddenAdText'
    local receiver = msg.to.id
    send_large_msg('chat#id'..receiver, msg.."\n", ok_cb, false)
      end
   end
end
return {
patterns = {
"#(.*)",
"@(.*)"
},
run = run
}
