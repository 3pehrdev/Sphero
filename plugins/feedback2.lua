do


function run(msg, matches)


local fuse = '#newfeedback \nID▶️ : ' .. msg.from.id .. '\nName▶️ : ' .. msg.from.print_name ..'\nusername▶️ : @'.. msg.from.username ..'\n🅿️♏️ :\n' .. matches[1]

local fuses = '!printf user#id' .. msg.from.id



    local text = matches[1]

 bannedidone = string.find(msg.from.id, '123')

        bannedidtwo =string.find(msg.from.id, '465')

   bannedidthree =string.find(msg.from.id, '678')



        print(msg.to.id)


        if bannedidone or bannedidtwo or bannedidthree then --for banned people

                return 'You are banned to send a feedback'

 else



                 local sends0 = send_msg('chat# 110380705 ', fuse, ok_cb, false)


 return 'Succesfully Send!'




end


end

return {

  description = "Feedback",


  usage = "!feedback : send maseage to admins with bot",
},
  patterns = {

    "^![Ff]eedback (.*)$"


  },

  run = run

}


end
