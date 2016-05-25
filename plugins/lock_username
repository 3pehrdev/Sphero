
antiusername = {}-- An empty table for solving multiple kicking problem

do
local function run(msg, matches)
  if is_momod(msg) then -- Ignore mods,owner,admins
    return
  end
  local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)]['settings']['antitag'] then
    if data[tostring(msg.to.id)]['settings']['antitag'] == 'yes' then
      if antiusername[msg.from.id] == true then 
        return
      end
      send_large_msg("chat#id".. msg.to.id , "username is not allowed here")
      local name = user_print_name(msg.from)
      savelog(msg.to.id, name.." ["..msg.from.id.."] kicked (username was locked) ")
      chat_del_user('chat#id'..msg.to.id,'user#id'..msg.from.id,ok_cb,false)
		  antiusername[msg.from.id] = true
      return
    end
  end
  return
end
local function cron()
  antiusername = {} -- Clear antiusername table 
end
return {
  patterns = {
    "@ (.+)",
    "@(.+)",
    "(.+)@",
    "(.+) @"
    },
  run = run,
	cron = cron
}

end
