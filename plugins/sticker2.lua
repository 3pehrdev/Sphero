local function tosticker(msg, success, result) 
  local receiver = get_receiver(msg) 
  if success then 
    local file = 'sticker/'..msg.from.id..'.webp' 
    print('File downloaded to:', result) 
    os.rename(result, file) 
    print('File moved to:', file) 
    send_document(get_receiver(msg), file, ok_cb, false) 
    redis:del("photo:sticker") 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 
local function toimage(msg, success, result) 
  local receiver = get_receiver(msg) 
  if success then 
    local photofile = 'sticker/'..msg.from.id..'.jpg' 
    print('File downloaded to:', result) 
    os.rename(result, photofile) 
    print('File moved to:', file) 
    send_photo(get_receiver(msg), photofile, ok_cb, false) 
    redis:del("sticker:photo") 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 

local function run(msg, matches) 
    if matches[1] == 'st' then 
        local text = URL.escape(matches[2]) 
        local color = 'blue' 
        if matches[3] == 'red' then 
            color = 'red' 
        elseif matches[3] == 'black' then 
            color = 'black' 
      elseif matches[3] == 'blue' then 
          color = 'blue' 
    elseif matches[3] == 'green' then 
        color = 'green' 
    elseif matches[3] == 'yellow' then 
        color = 'yellow' 
    elseif matches[3] == 'pink' then 
        color = 'magenta' 
    elseif matches[3] == 'orange' then 
        color = 'Orange' 
    elseif matches[3] == 'brown' then 
        color = 'DarkOrange' 
        end 
        local font = 'mathrm' 
        if matches[4] == 'bold' then 
            font = 'mathbf' 
        elseif matches[4] == 'italic' then 
            font = 'mathit' 
        elseif matches[4] == 'fun' then 
            font = 'mathfrak' 
        elseif matches[4] == 'arial' then 
            font = 'mathrm' 
        end 
        local size = '700' 
        if matches[5] == 'small' then 
            size = '300' 
        elseif matches[5] == 'larg' then 
            size = '700' 
            end 
local url = 'http://latex.codecogs.com/png.latex?'..'\\dpi{'..size..'}%20\\huge%20\\'..font..'{{\\color{'..color..'}'..text..'}}' 
local file = download_to_file(url,'file.webp') 
        send_document(msg.to.id , file, ok_cb, false) 
        return "For Spherobot thanks to amirho3inf :)" 
end

    local receiver = get_receiver(msg) 
    local group = msg.to.id 
    if msg.reply_id then 
         if msg.to.type == 'photo' and redis:get("photo:sticker") then 
            if redis:set("photo:sticker", "waiting") then 
         elseif msg.to.type == 'document' and redis:get("sticker:photo") then 
            if redis:set("sticker:photo", "waiting") then 
            end 
     end 
     end 
      if matches[1] == "sticker" then 
       redis:get("photo:sticker") 
        load_photo(msg.reply_id, tosticker, msg) 
        return "For Spherobot thanks to amirho3inf :)" 
      elseif matches[1] == "photo" then 
       redis:get("sticker:photo") 
        load_document(msg.reply_id, toimage, msg) 
     return 'For Spherobot thanks to amirho3inf :)' 
    end 
end 

end 
return { 
    usage = {
"!sticker <reply> : photo to sticker by reply",
"!photo <reply> : sticker to photo by reply",
"!st [text] : text to sticker",
"!st [text] [color]",
"!st [text] [color] [font] [size]",
            }, 
   patterns = { 
       "^!(st) (.*) ([^%s]+) (.*) (small)$", 
       "^!(st) (.*) ([^%s]+) (.*) (larg)$", 
       "^!(st) (.*) ([^%s]+) (bold)$", 
       "^!(st) (.*) ([^%s]+) (italic)$", 
       "^!(st) (.*) ([^%s]+) (fun)$", 
       "^!(st) (.*) ([^%s]+) (arial)$", 
       "^!(st) (.*) (red)$", 
       "^!(st) (.*) (black)$", 
       "^!(st) (.*) (blue)$", 
       "^!(st) (.*) (green)$", 
       "^!(st) (.*) (yellow)$", 
       "^!(st) (.*) (pink)$", 
       "^!(st) (.*) (orange)$", 
       "^!(st) (.*) (brown)$", 
       "^!(st) +(.*)$", 
   "^!(sticker)$", 
   "%[(photo)%]", 
   "^!(photo)$", 
   "%[(document)%]", 
       }, 
   run = run 
} 
