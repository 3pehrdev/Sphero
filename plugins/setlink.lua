 local function run(msg, matches)
		if matches[1]:lower() == 'setlink' and is_owner(msg) then
			data[tostring(msg.to.id)]['settings']['set_link'] = 'waiting'
			save_data(_config.moderation.data, data)
			return 'Please Send Me Your New Group Link!'
		end

		if msg.text then
			if msg.text:match("^(https://telegram.me/joinchat/%S+)$") and data[tostring(msg.to.id)]['settings']['set_link'] == 'waiting' and is_owner(msg) then
				data[tostring(msg.to.id)]['settings']['set_link'] = msg.text
				save_data(_config.moderation.data, data)
				return "Link Has Been Saved!"
			end
	end
end
return {
  patterns = {
 "^[!#/](setlink)$",
    "^(https://telegram.me/joinchat/%S+)$",
  },
  run = run
}
