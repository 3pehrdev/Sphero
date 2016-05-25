do
local function run(msg, matches)
local data = load_data(_config.moderation.data)
if not is_chat_msg(msg) then
 return
else
if data[tostring(msg.to.id)] then
 local settings = data[tostring(msg.to.id)]['settings']
 if #matches == 2 then
  
  if matches[1] == 'ewlink' and is_momod(msg) then
   local function link_callback (extra , success, result)
    local receiver = extra.receiver
    if success == 0 then
     return "Error!"
    end
    data[tostring(msg.to.id)]['settings']['set_link'] = result
    save_data(_config.moderation.data, data)
    local group_link = data[tostring(msg.to.id)]['settings']['set_link']
    send_large_msg(receiver, "Newlink sent!")
    send_large_msg('user#'..msg.from.id, "Newlink has been Created :\n______________________________\n"..group_link)
   end
   local receiver = 'chat#'..msg.to.id
   return export_chat_link(receiver, link_callback, {receiver = receiver})

  elseif matches[1] == 'ink' and is_momod(msg) then
   local group_link = data[tostring(msg.to.id)]['settings']['set_link']
   if not group_link then
    return "First make a Newlink!"
   end
   send_large_msg('chat#'..msg.to.id, "Link sent!")
   send_large_msg('user#'..msg.from.id,"Group link for ".. msg.to.title.." : \n___________________\n"..group_link)
  end
  
 else
  
  if matches[1] == 'ewlink' and is_momod(msg) then
   local function link_callback (extra , success, result)
    local receiver = extra.receiver
    if success == 0 then
     return "Error!"
    end
    data[tostring(msg.to.id)]['settings']['set_link'] = result
    save_data(_config.moderation.data, data)
    local group_link = data[tostring(msg.to.id)]['settings']['set_link']
    send_large_msg(receiver, "Newlink has been Created :\n______________________________\n"..group_link)
   end
   local receiver = 'chat#'..msg.to.id
   return export_chat_link(receiver, link_callback, {receiver = receiver})
  
  elseif matches[1] == 'link' and is_momod(msg) then
   local function link_callback (extra , success, result)
    local receiver = extra.receiver
    if success == 0 then
     return "eror!"
    end
    data[tostring(msg.to.id)]['settings']['set_link'] = result
    save_data(_config.moderation.data, data)
    send_large_msg(receiver, "Link closed")
   end
   local receiver = 'chat#'..msg.to.id
   return export_chat_link(receiver, link_callback, {receiver = receiver})

  elseif matches[1] == 'ink' and is_momod(msg) then
   local group_link = data[tostring(msg.to.id)]['settings']['set_link']
   if not group_link then
    return "first use /newlink to create a newlink"
   end
   local text = "*Group Link for* ["..msg.to.title.."]("..group_link..")"
send_api_msg(msg, get_receiver_api(msg), text, true, 'md') 
 end
 end
end
end
end
 
return {
  description = "Link Manager System",
  usage = {
  moderator = {
 "link : Show Group Link",
 "link pv : send link to your private",
 "newlink : create a newlink",
 "newlink pv : send group newlink to your private msg",
 "clink : closed link",
    },
 },
  patterns = {
    "^[Nn](ewlink)$",
    "^[Ll](ink)$",
 "^[Nn](ewlink) (pv)$",
    "^[Ll](ink) (pv)$",
 "^[Cc](link)$",
  },
  run = run,
  moderated = true
}
end
