function run(msg,matches)
if matches[1]:lower() == 'حذف همه' and is_mod(msg)  then
local function pro(arg,data)
for k,v in pairs(data.members) do
tdbot.deleteMessagesFromUser(msg.chat_id, v.user_id, dl_cb, nil) 
end
end
local function cb(arg,data)
for k,v in pairs(data.messages) do
del_msg(msg.chat_id, v.id)
end
end

for i = 1, 5 do
tdbot.getChatHistory(msg.to.id, msg.id, 0,  500000000, 0, cb, nil)
end
for i = 1, 2 do
tdbot.getChannelMembers(msg.to.id, 0, 50000, "Search", pro, nil)
end
for i = 1, 1 do
tdbot.getChannelMembers(msg.to.id, 0, 50000, "Recent", pro, nil)
end
for i = 1, 5 do
tdbot.getChannelMembers(msg.to.id, 0, 50000, "Banned", pro, nil)
end
return "`💥درحال پاک کردن کل پیام های گروه`\n@RadicalBotTeam"
end
end

return {
	patterns = {
	"^(حذف همه)$",
	},
	run = run
}
