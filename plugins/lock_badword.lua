local function run(msg, matches)
if msg.to.type == 'chat' then
    if is_owner(msg) then
        return
    end
    local data = load_data(_config.moderation.data)
    if data[tostring(msg.to.id)] then
        if data[tostring(msg.to.id)]['settings'] then
            if data[tostring(msg.to.id)]['settings']['lock_badw'] then
                lock_adds = data[tostring(msg.to.id)]['settings']['lock_badw']
            end
        end
    end
    local chat = get_receiver(msg)
    local user = "user#id"..msg.from.id
    if lock_adds == "yes" then
        send_large_msg(chat, 'Badwords is not allowed here!!')
        chat_del_user(chat, user, ok_cb, true)
    end
end
end
return {
  patterns = {
    "(ک*س)$",
    "کیر",
	"کص",
	"کــــــــــیر",
	"کــــــــــــــــــــــــــــــیر",
	"کـیـــــــــــــــــــــــــــــــــــــــــــــــــــر",
    "ک×یر",
	"ک÷یر",
	"ک*ص",
	"کــــــــــیرر",
    "kir",
	"kos",
	"koon",
	"کص",
	"کونی",
	"گوساله",
	"gosale",
	"gusale"
  },
  run = run
}
Status API Training Shop Blog About
© 2016 GitHub, Inc. Terms Privacy Security Contact Help
