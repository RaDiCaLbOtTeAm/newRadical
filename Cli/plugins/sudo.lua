--Begin Tools.lua :)
local SUDO = 516488530 -- put Your ID here! <===
function exi_files(cpath)
    local files = {}
    local pth = cpath
    for k, v in pairs(scandir(pth)) do
		table.insert(files, v)
    end
    return files
end

local function file_exi(name, cpath)
    for k,v in pairs(exi_files(cpath)) do
        if name == v then
            return true
        end
    end
    return false
end
local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
local function index_function(user_id)
  for k,v in pairs(_config.admins) do
    if user_id == v[1] then
    	print(k)
      return k
    end
  end
  -- If not found
  return false
end

local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 

local function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v then
      return k
    end
  end
  -- If not found
  return false
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end

local function exi_file()
    local files = {}
    local pth = tcpath..'/files/documents'
    for k, v in pairs(scandir(pth)) do
        if (v:match('.lua$')) then
            table.insert(files, v)
        end
    end
    return files
end

local function pl_exi(name)
    for k,v in pairs(exi_file()) do
        if name == v then
            return true
        end
    end
    return false
end

local function sudolist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = "`💥List of sudo users :`\n"
   else
 text = "`💥لیست سودو های ربات :`\n"
  end
for i=1,#sudo_users do
    text = text..i.."` - "..sudo_users[i].."`\n"
end
return text
end

local function adminlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = '`💥List of bot admins :`\n'
   else
 text = "`💥لیست ادمین های ربات :`\n"
  end
		  	local compare = text
		  	local i = 1
		  	for v,user in pairs(_config.admins) do
			    text = text..i..'- '..(user[2] or '')..' ➣ `('..user[1]..')`'
		  	i = i +1
		  	end
		  	if compare == text then
   if not lang then
		  		text = '`💥No admins available`\n`Channel:`\n@RadicalBotTeam'
      else
		  		text = '`💥ادمینی برای ربات تعیین نشده`\n`کانال ما:`\n@RadicalBotTeam'
           end
		  	end
		  	return text
    end

local function chat_list(msg)
	i = 1
	local data = load_data(_config.moderation.data)
    local groups = 'groups'
    if not data[tostring(groups)] then
        return '`💥No groups at the moment`\n`Channel:`\n@RadicalBotTeam'
    end
    local message = '`💥List of Groups:`\nUse #join (ID) to join\n\n'
    for k,v in pairsByKeys(data[tostring(groups)]) do
		local group_id = v
		if data[tostring(group_id)] then
			settings = data[tostring(group_id)]['settings']
		end
        for m,n in pairsByKeys(settings) do
			if m == 'set_name' then
				name = n:gsub("", "")
				chat_name = name:gsub("‮", "")
				group_name_id = name .. '\n(ID: ' ..group_id.. ')\n\n'
				if name:match("[\216-\219][\128-\191]") then
					group_info = i..' - \n'..group_name_id
				else
					group_info = i..' - '..group_name_id
				end
				i = i + 1
			end
        end
		message = message..group_info
    end
	return message
end

local function botrem(msg)
	local data = load_data(_config.moderation.data)
	data[tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	local groups = 'groups'
	if not data[tostring(groups)] then
		data[tostring(groups)] = nil
		save_data(_config.moderation.data, data)
	end
	data[tostring(groups)][tostring(msg.to.id)] = nil
	save_data(_config.moderation.data, data)
	if redis:get('CheckExpire::'..msg.to.id) then
		redis:del('CheckExpire::'..msg.to.id)
	end
	if redis:get('ExpireDate:'..msg.to.id) then
		redis:del('ExpireDate:'..msg.to.id)
	end
	tdbot.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
end

local function warning(msg)
	local hash = "gp_lang:"..msg.to.id
	local lang = redis:get(hash)
	local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
	if expiretime == -1 then
		return
	else
	local d = math.floor(expiretime / 86400) + 1
        if tonumber(d) == 1 and not is_sudo(msg) and is_mod(msg) then
			if lang then
				tdbot.sendMessage(msg.to.id, 0, 1, '`💥یک روز گروه شما شارژ داری و پس اتمام خارج میشود برای شارژ مجدد به ادمین یا سودو مراجعه کنید`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
			else
				tdbot.sendMessage(msg.to.id, 0, 1, '`💥Group 1 day remaining charge, to recharge the robot contact with the sudo. With the completion of charging time, the group removed from the robot list and the robot will leave the group.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
			end
		end
	end
end

local function action_by_reply(arg, data)
    local cmd = arg.cmd
if not tonumber(data.sender_user_id) then return false end
    if data.sender_user_id then
    if cmd == "adminprom" then
local function adminprom_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if is_admin1(tonumber(data.id)) then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User` "..user_name.." "..data.id.."` is already an admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
  else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر `"..user_name.." "..data.id.." `از قبل ادمین ربات بود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id), user_name})
		save_config()
     if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User`"..user_name.." "..data.id.." `has been promoted as admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر `"..user_name.." "..data.id.." `به مقام ادمین ربات منتصب شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, adminprom_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "admindem" then
local function admindem_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
	local nameid = index_function(tonumber(data.id))
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not is_admin1(data.id) then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User `"..user_name.." "..data.id.."`is not a admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر `"..user_name.." "..data.id.."`از قبل ادمین ربات نبود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User` "..user_name.." "..data.id.." `has been demoted from admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر `"..user_name.." "..data.id.."` از مقام ادمین ربات برکنار شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, admindem_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "visudo" then
local function visudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if already_sudo(tonumber(data.id)) then
  if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User`"..user_name.." *"..data.id.."`is already a sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر` "..user_name.." "..data.id.."`از قبل سودو ربات بود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User`"..user_name.." "..data.id.."`is now sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
  else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر` "..user_name.." "..data.id.." `به مقام سودو ربات منتصب شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, visudo_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
    if cmd == "desudo" then
local function desudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
     if not already_sudo(data.id) then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User `"..user_name.." "..data.id.." `is not a sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر`"..user_name.." "..data.id.." `از قبل سودو ربات نبود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User` "..user_name.." "..data.id.." `is no longer a sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر `"..user_name.." "..data.id.." `از مقام سودو ربات برکنار شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.sender_user_id
  }, desudo_cb, {chat_id=data.chat_id,user_id=data.sender_user_id})
  end
else
    if lang then
  return tdbot.sendMessage(data.chat_id, "", 0, "`💥کاربر یافت نشد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   else
  return tdbot.sendMessage(data.chat_id, "", 0, "`💥User Not Found`\n`Channel:`\n@RadicalBotTeam", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not arg.username then return false end
    if data.id then
    if cmd == "adminprom" then
local function adminprom_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥This user doesn't exists.`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥 کاربر موردنظر وجود ندارد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if is_admin1(tonumber(data.id)) then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User `"..user_name.." "..data.id.."` is already an admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
  else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر `"..user_name.." "..data.id.."` از قبل ادمین ربات بود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id), user_name})
		save_config()
     if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User` "..user_name.." "..data.id.." `has been promoted as admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر `"..user_name.." "..data.id.."`به مقام ادمین ربات منتصب شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, adminprom_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "admindem" then
local function admindem_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥This user doesn't exists.`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥 کاربر موردنظر وجود ندارد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
     end
 end
	local nameid = index_function(tonumber(data.id))
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if not is_admin1(data.id) then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User` "..user_name.." "..data.id.."` is not a admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر`"..user_name.." "..data.id.." `از قبل ادمین ربات نبود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User`"..user_name.." "..data.id.." `has been demoted from admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر `"..user_name.." "..data.id.."` از مقام ادمین ربات برکنار شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, admindem_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "visudo" then
local function visudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥This user doesn't exists.`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥 کاربر موردنظر وجود ندارد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
if already_sudo(tonumber(data.id)) then
  if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User`"..user_name.." "..data.id.." `is already a sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر` "..user_name.." "..data.id.."` از قبل سودو ربات بود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User` "..user_name.." "..data.id.." `is now sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
  else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر`"..user_name.." "..data.id.." `به مقام سودو ربات منتصب شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, visudo_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
    if cmd == "desudo" then
local function desudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not data.id then 
  if not lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥This user doesn't exists.`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥 کاربر موردنظر وجود ندارد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
     end
 end
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
     if not already_sudo(data.id) then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User` "..user_name.." "..data.id.."` is not a sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر`"..user_name.." "..data.id.." `از قبل سودو ربات نبود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User "..user_name.." "..data.id.." is no longer a sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر "..user_name.." "..data.id.." از مقام سودو ربات برکنار شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   end
end
tdbot_function ({
    _ = "getUser",
    user_id = data.id
  }, desudo_cb, {chat_id=arg.chat_id,user_id=data.id})
  end
else
    if lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥 کاربر یافت نشد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User Not Found`\n`Channel:`\n@RadicalBotTeam", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not tonumber(arg.user_id) then return false end
   if data.id then
if data.username then
user_name = '@'..check_markdown(data.username)
else
user_name = check_markdown(data.first_name)
end
    if cmd == "adminprom" then
if is_admin1(tonumber(data.id)) then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User"..user_name.." "..data.id.." is already an admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
  else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر"..user_name.." "..data.id.." از قبل ادمین ربات بود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id), user_name})
		save_config()
     if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User "..user_name.." "..data.id.." has been promoted as admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
    else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر"..user_name.." "..data.id.." به مقام ادمین ربات منتصب شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   end
end 
    if cmd == "admindem" then
	local nameid = index_function(tonumber(data.id))
if not is_admin1(data.id) then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User "..user_name.." "..data.id.." is not a admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر"..user_name.." "..data.id.." از قبل ادمین ربات نبود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User "..user_name.." "..data.id.."has been demoted from admin`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر "..user_name.." "..data.id.." از مقام ادمین ربات برکنار شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   end
end
    if cmd == "visudo" then
if already_sudo(tonumber(data.id)) then
  if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User "..user_name.." "..data.id.." is already a sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر"..user_name.." "..data.id.." از قبل سودو ربات بود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User "..user_name.." "..data.id.." is now sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
  else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر "..user_name.." "..data.id.." به مقام سودو ربات منتصب شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   end
end
    if cmd == "desudo" then
     if not already_sudo(data.id) then
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User "..user_name.." "..data.id.." is not a sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر"..user_name.." "..data.id.." از قبل سودو ربات نبود`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User"..user_name.." "..data.id.." is no longer a sudoer`\n`Channel:`\n@RadicalBotTeam", 0, "md")
   else
    return tdbot.sendMessage(arg.chat_id, "", 0, "`💥کاربر"..user_name.." "..data.id.." از مقام سودو ربات برکنار شد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
      end
   end
else
    if lang then
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥  کاربر یافت نشد`\n`کانال ما:`\n@RadicalBotTeam", 0, "md")
   else
  return tdbot.sendMessage(arg.chat_id, "", 0, "`💥User Not Found`\n`Channel:`\n@RadicalBotTeam", 0, "md")
      end
   end
end

local function pre_process(msg)
	if msg.to.type ~= 'pv' then
		local hash = "gp_lang:"..msg.to.id
		local lang = redis:get(hash)
		local data = load_data(_config.moderation.data)
		local gpst = data[tostring(msg.to.id)]
		local chex = redis:get('CheckExpire::'..msg.to.id)
		local exd = redis:get('ExpireDate:'..msg.to.id)
		if gpst and not chex and msg.from.id ~= SUDO and not is_sudo(msg) then
			redis:set('CheckExpire::'..msg.to.id,true)
			redis:set('ExpireDate:'..msg.to.id,true)
			redis:setex('ExpireDate:'..msg.to.id, 86400, true)
			if lang then
				tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥گروه به مدت 1 روز شارژ شد. لطفا با سودو برای شارژ بیشتر تماس بگیرید. در غیر اینصورت گروه شما از لیست ربات حذف و ربات گروه را ترک خواهد کرد.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
			else
				tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥Group charged 1 day. to recharge the robot contact with the sudo. With the completion of charging time, the group removed from the robot list and the robot will leave the group.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
			end
		end
		if chex and not exd and msg.from.id ~= SUDO and not is_sudo(msg) then
			local text1 = '💥شارژ این گروه به اتمام رسید \n\nID:  <code>'..msg.to.id..'</code>\n\nدر صورتی که میخواهید ربات این گروه را ترک کند از دستور زیر استفاده کنید\n\n/leave '..msg.to.id..'\nبرای جوین دادن توی این گروه میتونی از دستور زیر استفاده کنی:\n/jointo '..msg.to.id..'\n_________________\nدر صورتی که میخواهید گروه رو دوباره شارژ کنید میتوانید از کد های زیر استفاده کنید...\n\n<b>برای شارژ 1 ماهه:</b>\n/plan 1 '..msg.to.id..'\n\n<b>برای شارژ 3 ماهه:</b>\n/plan 2 '..msg.to.id..'\n\n<b>برای شارژ نامحدود:</b>\n/plan 3 '..msg.to.id
			local text2 = '💥شارژ این گروه به پایان رسید. به دلیل عدم شارژ مجدد، گروه از لیست ربات حذف و ربات از گروه خارج میشود.\nکانال ما:\n@RadicalBotTeam'
			local text3 = '💥Charging finished.\n\nGroup ID:\n\n*ID:* '..msg.to.id..'\n\nIf you want the robot to leave this group use the following command:\n\n/Leave '..msg.to.id..'\n\nFor Join to this group, you can use the following command:\n\n/Jointo '..msg.to.id..'\n\n_________________\n\nIf you want to recharge the group can use the following code:\n\nTo charge 1 month:\n\n/Plan 1 '..msg.to.id..'\n\nTo charge 3 months:\n\n/Plan 2 '..msg.to.id..'\n\nFor unlimited charge:\n\n/Plan 3 '..msg.to.id..''
			local text4 = '💥Charging finished. Due to lack of recharge remove the group from the robot list and the robot leave the group.\nChannel:\n@RadicalBotTeam'
			if lang then
				tdbot.sendMessage(SUDO, 0, 1, text1, 1, 'html')
				tdbot.sendMessage(msg.to.id, 0, 1, text2, 1, 'md')
			else
				tdbot.sendMessage(SUDO, 0, 1, text3, 1, 'md')
				tdbot.sendMessage(msg.to.id, 0, 1, text4, 1, 'md')
			end
			botrem(msg)
		else
			local expiretime = redis:ttl('ExpireDate:'..msg.to.id)
			local day = (expiretime / 86400)
			if tonumber(day) > 0.208 and not is_sudo(msg) and is_mod(msg) then
				warning(msg)
			end
		end
	end
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local Chash = "cmd_lang:"..msg.to.id
local Clang = redis:get(Chash)
 if tonumber(msg.from.id) == SUDO then
if ((matches[1] == "clean cache" and not Clang) or (matches[1] == "پاکسازی حافظه" and Clang)) then
     run_bash("rm -rf ~/.telegram-bot/cli/data/stickers/*")
     run_bash("rm -rf ~/.telegram-bot/cli/files/photos/*")
     run_bash("rm -rf ~/.telegram-bot/cli/files/animations/*")
     run_bash("rm -rf ~/.telegram-bot/cli/files/videos/*")
     run_bash("rm -rf ~/.telegram-bot/cli/files/music/*")
     run_bash("rm -rf ~/.telegram-bot/cli/files/voice/*")
     run_bash("rm -rf ~/.telegram-bot/cli/files/temp/*")
     run_bash("rm -rf ~/.telegram-bot/cli/data/temp/*")
     run_bash("rm -rf ~/.telegram-bot/cli/files/documents/*")
     run_bash("rm -rf ~/.telegram-bot/cli/data/profile_photos/*")
     run_bash("rm -rf ~/.telegram-bot/cli/files/video_notes/*")
	 run_bash("rm -rf ./data/photos/*")
    return "All Cache Has Been Cleared"
   end
if ((matches[1] == "visudo" and not Clang) or (matches[1] == "افزودن سودو" and Clang)) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="visudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="visudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="visudo"})
      end
   end
if ((matches[1] == "desudo" and not Clang) or (matches[1] == "حذف سودو" and Clang)) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="desudo"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="desudo"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="desudo"})
      end
   end
end
		if ((matches[1] == "config" and not Clang) or (matches[1] == "ترفیع گروه" and Clang)) and is_admin(msg) then
			return set_config(msg)
		end
if is_sudo(msg) then
   		if ((matches[1]:lower() == 'install' and not Clang) or (matches[1] == "نصب" and Clang)) and not redis:get('ExpireDate:'..msg.to.id) then
			redis:set('ExpireDate:'..msg.to.id,true)
			redis:setex('ExpireDate:'..msg.to.id, 180, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id,true)
				end
				if lang then
					tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥گروه به مدت 3 دقیقه برای اجرای تنظیمات شارژ میباشد.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥Group charged 3 minutes  for settings.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
				end
		end
		if ((matches[1] == 'uninstall' and not Clang) or (matches[1] == "لغو نصب" and Clang)) then
			if redis:get('CheckExpire::'..msg.to.id) then
				redis:del('CheckExpire::'..msg.to.id)
			end
			redis:del('ExpireDate:'..msg.to.id)
		end
		if ((matches[1]:lower() == 'gpid' and not Clang) or (matches[1] == "مشخصات" and Clang)) then
			tdbot.sendMessage(msg.to.id, msg.id, 1, '`'..msg.to.id..'`', 1,'md')
		end
		if ((matches[1] == 'leave' and not Clang) or (matches[1] == "خروج از گروه" and Clang)) and matches[2] then
			if lang then
				tdbot.sendMessage(matches[2], 0, 1, '`💥ربات با دستور سودو از گروه خارج شد.`\n`برای اطلاعات بیشتر با سودو تماس بگیرید.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
				tdbot.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
				tdbot.sendMessage(SUDO, msg.id, 1, '`💥ربات با موفقیت از گروه '..matches[2]..' خارج شد.`\n`کانال ما:`\n@RadicalBotTeam', 1,'md')
			else
				tdbot.sendMessage(matches[2], 0, 1, '`💥Robot left the group.\nFor more information contact The SUDO.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
				tdbot.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
				tdbot.sendMessage(SUDO, msg.id, 1, '`💥Robot left from under group successfully:`\n\n`'..matches[2]..'`\n`Channel:`\n@RadicalBotTeam', 1,'md')
			end
		end
		if ((matches[1]:lower() == 'expire' and not Clang) or (matches[1] == "انقضا" and Clang)) and matches[2] and matches[3] then
		if string.match(matches[2], '^-%d+$') then
			if tonumber(matches[3]) > 0 and tonumber(matches[3]) < 1001 then
				local extime = (tonumber(matches[3]) * 86400)
				redis:setex('ExpireDate:'..matches[2], extime, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id,true)
				end
				if lang then
					tdbot.sendMessage(SUDO, 0, 1, '`💥ربات در گروه '..matches[2]..' به مدت '..matches[3]..' روز تمدید گردید.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
					tdbot.sendMessage(matches[2], 0, 1, '`💥ربات توسط ادمین به مدت '..matches[3]..' روز شارژ شد`\nبرای مشاهده زمان شارژ گروه دستور /expire استفاده کنید`\n`کانال ما:`\n@RadicalBotTeam',1 , 'md')
				else
					tdbot.sendMessage(SUDO, 0, 1, '`💥Recharged successfully in the group:` `'..matches[2]..'`\nExpire Date: `'..matches[3]..'` Day(s)', 1, 'md')
					tdbot.sendMessage(matches[2], 0, 1, '`💥Robot recharged '..matches[3]..' day(s)`\n`For checking expire date, send` /expire`\n`Channel:`\n@RadicalBotTeam',1 , 'md')
				end
			else
				if lang then
					tdbot.sendMessage(msg.to.id, msg.id, 1, 'تعداد روزها باید عددی از`💥 1 تا 1000 باشد.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥Expire days must be between 1 - 1000`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
				end
			end
		end
		end
		if ((matches[1]:lower() == 'plan' and not Clang) or (matches[1] == "پلن" and Clang)) then 
		if matches[2] == '1' and matches[3] then
		if string.match(matches[3], '^-%d+$') then
			local timeplan1 = 2592000
			redis:setex('ExpireDate:'..matches[3], timeplan1, true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdbot.sendMessage(SUDO, msg.id, 1, '`💥پلن با موفقیت برای گروه '..matches[3]..' فعال شد`\nاین گروه تا` 30 روز دیگر اعتبار دارد! ( 1 ماه (`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
				tdbot.sendMessage(matches[3], 0, 1, '`💥ربات با موفقیت فعال شد و تا 30 روز دیگر اعتبار دارد!`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
			else
				tdbot.sendMessage(SUDO, msg.id, 1, '`💥Plan 1 Successfully Activated!`\n`This group recharged with plan 1 for 30 days (1 Month)`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
				tdbot.sendMessage(matches[3], 0, 1, '`💥Successfully recharged`\n`Expire Date: 30 Days (1 Month)`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
			end
		end
		end
		if matches[2] == '2' and matches[3] then
		if string.match(matches[3], '^-%d+$') then
			local timeplan2 = 7776000
			redis:setex('ExpireDate:'..matches[3],timeplan2,true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdbot.sendMessage(SUDO, 0, 1, '`💥پلن  با موفقیت برای گروه` '..matches[3]..' `فعال شد`\nاین گروه تا` 90 روز دیگر اعتبار دارد! ( 3 ماه )`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
				tdbot.sendMessage(matches[3], 0, 1, '`💥ربات با موفقیت فعال شد و تا 90 روز دیگر اعتبار دارد! ( 3 ماه )`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
			else
				tdbot.sendMessage(SUDO, msg.id, 1, '`💥Plan 2 Successfully Activated!`\n`This group recharged with plan 2 for 90 days (3 Month)`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
				tdbot.sendMessage(matches[3], 0, 1, '`💥Successfully recharged`\n`Expire Date: 90 Days (3 Months)`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
			end
		end
		end
		if matches[2] == '3' and matches[3] then
		if string.match(matches[3], '^-%d+$') then
			redis:set('ExpireDate:'..matches[3],true)
			if not redis:get('CheckExpire::'..msg.to.id) then
				redis:set('CheckExpire::'..msg.to.id,true)
			end
			if lang then
				tdbot.sendMessage(SUDO, msg.id, 1, 'پلن`💥 3 با موفقیت برای گروه '..matches[3]..'فعال شد`\n`این گروه به صورت نامحدود شارژ شد!`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
				tdbot.sendMessage(matches[3], 0, 1, '`💥ربات بدون محدودیت فعال شد ! ( نامحدود )`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
			else
				tdbot.sendMessage(SUDO, msg.id, 1, '`💥Plan 3 Successfully Activated!`\n`This group recharged with plan 3 for unlimited`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
				tdbot.sendMessage(matches[3], 0, 1, '`💥Successfully recharged`\n`Expire Date: Unlimited`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
			end
		end
		end
		end
		if ((matches[1]:lower() == 'join' and not Clang) or (matches[1] == "ورود" and Clang)) and matches[2] then
		if string.match(matches[2], '^-%d+$') then
			if lang then
				tdbot.sendMessage(SUDO, msg.id, 1, '`💥با موفقیت تورو به گروه '..matches[2]..' اضافه کردم.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
				tdbot.addChatMember(matches[2], SUDO, 0, dl_cb, nil)
				tdbot.sendMessage(matches[2], 0, 1, '`💥 سودو به گروه اضافه شد.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
			else
				tdbot.sendMessage(SUDO, msg.id, 1, '`💥I added you to this group:\n\n`'..matches[2]..'`', 1, 'md')
				tdbot.addChatMember(matches[2], SUDO, 0, dl_cb, nil)
				tdbot.sendMessage(matches[2], 0, 1, '`💥Admin Joined!`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
			end
		end
		end
end
	if ((matches[1]:lower() == 'savefile' and not Clang) or (matches[1] == "ذخیره فایل" and Clang)) and matches[2] and is_sudo(msg) then
		if msg.reply_id  then
			local folder = matches[2]
            function get_filemsg(arg, data)
				function get_fileinfo(arg,data)
                    if data.content._ == 'messageDocument' or data.content._ == 'messagePhoto' or data.content._ == 'messageSticker' or data.content._ == 'messageAudio' or data.content._ == 'messageVoice' or data.content._ == 'messageVideo' or data.content._ == 'messageAnimation' then
                        if data.content._ == 'messageDocument' then
							local doc_id = data.content.document.document.id
							local filename = data.content.document.file_name
                            local pathf = tcpath..'/files/documents/'..filename
							local cpath = tcpath..'/files/documents'
                            if file_exi(filename, cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(doc_id)
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>فایل</b> <code>'..folder..'</code> <b>ذخیره شد.</b>', 1, 'html')
								else
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>File</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥 فایل مورد نظر وجود ندارد. فایل را دوباره ارسال کنید.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
								else
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥This file does not exist. Send file again.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
								end
                            end
						end
						if data.content._ == 'messagePhoto' then
							local photo_id = data.content.photo.sizes[2].photo.id
							local file = data.content.photo.id
                            local pathf = tcpath..'/files/photos/'..file..'_(0).jpg'
							if not pathf then
								pathf = tcpath..'/files/photos/'..file..'.jpg'
							end
							local cpath = tcpath..'/files/photos'
                            if file_exi(file..'.jpg', cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(photo_id)
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>عکس</b> <code>'..folder..'</code> <b>ذخیره شد.</b>', 1, 'html')
								else
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>Photo</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥 فایل مورد نظر وجود ندارد. فایل را دوباره ارسال کنید.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
								else
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥This file does not exist. Send file again.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
								end
                            end
						end
		                if data.content._ == 'messageSticker' then
							local stpath = data.content.sticker.sticker.path
							local sticker_id = data.content.sticker.sticker.id
							local secp = tostring(tcpath)..'/data/stickers/'
							local ffile = string.gsub(stpath, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(stpath, pfile)
                                file_dl(sticker_id)
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>استیکر</b> <code>'..folder..'</code> <b>ذخیره شد.</b>', 1, 'html')
								else
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>Sticker</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥 فایل مورد نظر وجود ندارد. فایل را دوباره ارسال کنید.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
								else
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥This file does not exist. Send file again.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
								end
                            end
						end
						if data.content._ == 'messageAudio' then
						local audio_id = data.content.audio.audio.id
						local audio_name = data.content.audio.file_name
                        local pathf = tcpath..'/files/music/'..audio_name
						local cpath = tcpath..'/files/music'
							if file_exi(audio_name, cpath) then
								local pfile = folder
								os.rename(pathf, pfile)
								file_dl(audio_id)
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>صدای</b> <code>'..folder..'</code> <b>ذخیره شد.</b>', 1, 'html')
								else
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>Audio</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
							else
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥 فایل مورد نظر وجود ندارد. فایل را دوباره ارسال کنید.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
								else
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥This file does not exist. Send file again.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
								end
							end
						end
						if data.content._ == 'messageVoice' then
							local voice_id = data.content.voice.voice.id
							local file = data.content.voice.voice.path
							local secp = tostring(tcpath)..'/files/voice/'
							local ffile = string.gsub(file, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(file, pfile)
                                file_dl(voice_id)
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>صوت</b> <code>'..folder..'</code> <b>ذخیره شد.</b>', 1, 'html')
								else
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>Voice</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥 فایل مورد نظر وجود ندارد. فایل را دوباره ارسال کنید.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
								else
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥This file does not exist. Send file again.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
								end
                            end
						end
						if data.content._ == 'messageVideo' then
							local video_id = data.content.video.video.id
							local file = data.content.video.video.path
							local secp = tostring(tcpath)..'/files/videos/'
							local ffile = string.gsub(file, '-', '')
							local fsecp = string.gsub(secp, '-', '')
							local name = string.gsub(ffile, fsecp, '')
                            if file_exi(name, secp) then
                                local pfile = folder
                                os.rename(file, pfile)
                                file_dl(video_id)
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>ویديو</b> <code>'..folder..'</code> <b>ذخیره شد.</b>', 1, 'html')
								else
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>Video</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥 فایل مورد نظر وجود ندارد. فایل را دوباره ارسال کنید.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
								else
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥This file does not exist. Send file again.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
								end
                            end
						end
						if data.content._ == 'messageAnimation' then
							local anim_id = data.content.animation.animation.id
							local anim_name = data.content.animation.file_name
                            local pathf = tcpath..'/files/animations/'..anim_name
							local cpath = tcpath..'/files/animations'
                            if file_exi(anim_name, cpath) then
                                local pfile = folder
                                os.rename(pathf, pfile)
                                file_dl(anim_id)
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>تصویر متحرک</b> <code>'..folder..'</code> <b>ذخیره شد.</b>', 1, 'html')
								else
									tdbot.sendMessage(msg.to.id, msg.id,1, '<b>Gif</b> <code>'..folder..'</code> <b>Has Been Saved.</b>', 1, 'html')
								end
                            else
								if lang then
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥 فایل مورد نظر وجود ندارد. فایل را دوباره ارسال کنید.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
								else
									tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥This file does not exist. Send file again.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
								end
                            end
						end
                    else
                        return
                    end
                end
                tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = data.id }, get_fileinfo, nil)
            end
	        tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = msg.reply_to_message_id }, get_filemsg, nil)
        end
    end
	if msg.to.type == 'channel' or msg.to.type == 'chat' then
		if ((matches[1] == 'expire' and not Clang) or (matches[1] == "انقضا" and Clang)) and matches[2] and not matches[3] and is_sudo(msg) then
			if tonumber(matches[2]) > 0 and tonumber(matches[2]) < 1001 then
				local extime = (tonumber(matches[2]) * 86400)
				redis:setex('ExpireDate:'..msg.to.id, extime, true)
				if not redis:get('CheckExpire::'..msg.to.id) then
					redis:set('CheckExpire::'..msg.to.id)
				end
				if lang then
					tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥ربات با موفقیت تنظیم شد`\n`مدت فعال بودن ربات در گروه به `'..matches[2]..'` روز دیگر تنظیم شد`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
					tdbot.sendMessage(SUDO, 0, 1, '`💥ربات در گروه `'..matches[2]..' `به مدت` '..msg.to.id..' `روز تمدید گردید.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥ربات با موفقیت تنظیم شد`\n`مدت فعال بودن ربات در گروه به` '..matches[2]..'` روز دیگر تنظیم شد`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
					tdbot.sendMessage(SUDO, 0, 1, '`💥ربات در گروه `'..matches[2]..'` به مدت` '..msg.to.id..' `روز تمدید گردید.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
				end
			else
				if lang then
					tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥تعداد روزها باید عددی از 1 تا 1000 باشد.`\n`کانال ما:`\n@RadicalBotTeam', 1, 'md')
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥Expire days must be between 1 - 1000`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
				end
			end
		end
		if ((matches[1]:lower() == 'expire' and not Clang) or (matches[1] == "انقضا" and Clang)) and is_mod(msg) and not matches[2] then
			local check_time = redis:ttl('ExpireDate:'..msg.to.id)
			year = math.floor(check_time / 31536000)
			byear = check_time % 31536000
			month = math.floor(byear / 2592000)
			bmonth = byear % 2592000
			day = math.floor(bmonth / 86400)
			bday = bmonth % 86400
			hours = math.floor( bday / 3600)
			bhours = bday % 3600
			min = math.floor(bhours / 60)
			sec = math.floor(bhours % 60)
			if not lang then
				if check_time == -1 then
					remained_expire = '`💥Unlimited Charging!`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '`💥Expire until'..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '`💥Expire until '..min..' min '..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '`💥Expire until '..hours..'hour'..min..'min'..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '`💥Expire until'..day..'day'..hours..'hour'..min..'min'..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '`💥Expire until'..month..'month'..day..'day'..hours..'hour'..min..'min'..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '`💥Expire until'..year..'year'..month..'month'..day..'day'..hours..'hour'..min..'min'..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				end
				tdbot.sendMessage(msg.to.id, msg.id, 1, remained_expire, 1, 'md')
			else
				if check_time == -1 then
					remained_expire = '`💥گروه به صورت نامحدود شارژ میباشد!`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '`💥گروه به مدت '..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '`💥گروه به مدت'..min..'دقیقه و'..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '`💥گروه به مدت'..hours..'ساعت و'..min..'دقیقه و '..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '`💥گروه به مدت '..day..'روز و'..hours..'ساعت و'..min..'دقیقه و'..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '`💥گروه به مدت'..month..'ماه'..day..'روز و'..hours..'ساعت و'..min..'دقیقه و'..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '`💥گروه به مدت'..year..'سال'..month..'ماه'..day..'روز و'..hours..'ساعت و'..min..'دقیقه و'..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				end
				tdbot.sendMessage(msg.to.id, msg.id, 1, remained_expire, 1, 'md')
			end
		end
	end
	if ((matches[1] == 'expire' and not Clang) or (matches[1] == "انقضا" and Clang)) and is_mod(msg) and matches[2] then
		if string.match(matches[2], '^-%d+$') then
			local check_time = redis:ttl('ExpireDate:'..matches[2])
			year = math.floor(check_time / 31536000)
			byear = check_time % 31536000
			month = math.floor(byear / 2592000)
			bmonth = byear % 2592000
			day = math.floor(bmonth / 86400)
			bday = bmonth % 86400
			hours = math.floor( bday / 3600)
			bhours = bday % 3600
			min = math.floor(bhours / 60)
			sec = math.floor(bhours % 60)
			if not lang then
				if check_time == -1 then
					remained_expire = '`💥Unlimited Charging!`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '`💥Expire until'..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '`💥Expire until '..min..' min '..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '`💥Expire until '..hours..'hour'..min..'min'..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '`💥Expire until'..day..'day'..hours..'hour'..min..'min'..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '`💥Expire until'..month..'month'..day..'day'..hours..'hour'..min..'min'..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '`💥Expire until'..year..'year'..month..'month'..day..'day'..hours..'hour'..min..'min'..sec..'sec`\n`Channel:`\n@RadicalBotTeam'
				end
				tdbot.sendMessage(msg.to.id, msg.id, 1, remained_expire, 1, 'md')
			else
				if check_time == -1 then
					remained_expire = '`💥گروه به صورت نامحدود شارژ میباشد!`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 1 and check_time < 60 then
					remained_expire = '`💥گروه به مدت '..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 60 and check_time < 3600 then
					remained_expire = '`💥گروه به مدت'..min..'دقیقه و'..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
					remained_expire = '`💥گروه به مدت'..hours..'ساعت و'..min..'دقیقه و '..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
					remained_expire = '`💥گروه به مدت '..day..'روز و'..hours..'ساعت و'..min..'دقیقه و'..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
					remained_expire = '`💥گروه به مدت'..month..'ماه'..day..'روز و'..hours..'ساعت و'..min..'دقیقه و'..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				elseif tonumber(check_time) > 31536000 then
					remained_expire = '`💥گروه به مدت'..year..'سال'..month..'ماه'..day..'روز و'..hours..'ساعت و'..min..'دقیقه و'..sec..'ثانیه شارژ میباشد`\n`کانال ما:`\n@RadicalBotTeam'
				end
				tdbot.sendMessage(msg.to.id, msg.id, 1, remained_expire, 1, 'md')
			end
		end
		end
if ((matches[1] == "setadmin" and not Clang) or (matches[1] == "تنظیم ادمین" and Clang)) and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="adminprom"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="adminprom"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="adminprom"})
      end
   end
if ((matches[1] == "remadmin" and not Clang) or (matches[1] == "حذف ادمین" and Clang)) and is_sudo(msg) then
if not matches[2] and msg.reply_id then
    tdbot_function ({
      _ = "getMessage",
      chat_id = msg.to.id,
      message_id = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.to.id,cmd="admindem"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdbot_function ({
    _ = "getUser",
    user_id = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="admindem"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdbot_function ({
      _ = "searchPublicChat",
      username = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="admindem"})
      end
   end

if ((matches[1] == 'creategroup' and not Clang) or (matches[1] == "ساخت گروه" and Clang)) and is_admin(msg) then
local text = matches[2]
tdbot.createNewGroupChat({[0] = msg.from.id}, text, dl_cb, nil)
  if not lang then
return '`💥Group Has Been Created!`\n`Channel:`\n@RadicalBotTeam'
  else
return '`💥گروه ساخته شد!`\n`کانال ما:`\n@RadicalBotTeam'
   end
end

if ((matches[1] == 'createsuper' and not Clang) or (matches[1] == "ساخت سوپرگروه" and Clang)) and is_admin(msg) then
local text = matches[2]
tdbot.createNewChannelChat(text, 1, '@BeyondTeam', (function(b, d) tdbot.addChatMember(d.id, msg.from.id, 0, dl_cb, nil) end), nil)
   if not lang then 
return '`💥SuperGroup Has Been Created` and [`'..msg.from.id..'`] `Joined To This SuperGroup.`\n`Channel:`\n@RadicalBotTeam'
  else
return '`💥سوپرگروه ساخته شد و` [`'..msg.from.id..'`] `به گروه اضافه شد.`\n`کانال ما:`\n@RadicalBotTeam'
   end
end

if ((matches[1] == 'tosuper' and not Clang) or (matches[1] == "تبدیل به سوپرگروه" and Clang)) and is_admin(msg) then
local id = msg.to.id
tdbot.migrateGroupChatToChannelChat(id, dl_cb, nil)
  if not lang then
return '`💥Group Has Been Changed To SuperGroup!`\n`Channel:`\n@RadicalBotTeam'
  else
return '`💥گروه به سوپر گروه تبدیل شد!`\n`کانال ما:`\n@RadicalBotTeam'
   end
end

if ((matches[1] == 'import' and not Clang) or (matches[1] == "ورود لینک" and Clang)) and is_admin(msg) then
if matches[2]:match("^([https?://w]*.?telegram.me/joinchat/.*)$") or matches[2]:match("^([https?://w]*.?t.me/joinchat/.*)$") then
local link = matches[2]
if link:match('t.me') then
link = string.gsub(link, 't.me', 'telegram.me')
end
tdbot.importChatInviteLink(link, dl_cb, nil)
   if not lang then
return '`💥Ok Bye`\n`Channel:`\n@RadicalBotTeam'
  else
return '`💥حله بای`\n`کانال ما:`\n@RadicalBotTeam'
  end
  end
end

if ((matches[1] == 'setname' and not Clang) or (matches[1] == "تغییر نام" and Clang)) and is_sudo(msg) then
tdbot.changeName(matches[2], dl_cb, nil)
   if not lang then
return '`💥Bot Name Changed To:` '..matches[2]..'\n`Channel:`\n@RadicalBotTeam'
  else
return '`💥اسم ربات تغییر کرد به:` \n'..matches[2]..'\n`کانال ما:`\n@RadicalBotTeam'
   end
end

if ((matches[1] == 'setusername' and not Clang) or (matches[1] == "تغییر یوزرنیم" and Clang)) and is_sudo(msg) then
tdbot.changeUsername(matches[2], dl_cb, nil)
   if not lang then
return '`💥Bot Username Changed To:` @'..matches[2]..'\n`Channel:`\n@RadicalBotTeam'
  else
return '`💥یوزرنیم ربات تغییر کرد به:` \n@'..matches[2]..'\n`کانال ما:`\n@RadicalBotTeam'
   end
end

if ((matches[1] == 'remusername' and not Clang) or (matches[1] == "حذف یوزرنیم" and Clang)) and is_sudo(msg) then
tdbot.changeUsername('', dl_cb, nil)
   if not lang then
return '`💥Ok Bye`\n`Channel:`\n@RadicalBotTeam'
  else
return '`💥حله بای`\n`کانال ما:`\n@RadicalBotTeam'
  end
end

if ((matches[1] == 'markread' and not Clang) or (matches[1] == "" and Clang)) and is_sudo(msg) then
if ((matches[2] == '+' and not Clang) or (matches[2] == "+" and Clang)) then
redis:set('markread','on')
   if not lang then
return '`💥Markread > ON`\n`Channel:`\n@RadicalBotTeam'
else
return '`💥تیک دوم >روشن`\n`کانال ما:`\n@RadicalBotTeam'
   end
end
if ((matches[2] == '-' and not Clang) or (matches[2] == "-" and Clang)) then
redis:set('markread','off')
  if not lang then
return '`💥Markread > OFF`\n`Channel:`\n@RadicalBotTeam'
   else
return '`💥تیک دوم خاموش`\n`کانال ما:`\n@RadicalBotTeam'
      end
   end
end

if ((matches[1] == 'send' and not Clang) or (matches[1] == "ارسال" and Clang)) and is_admin(msg) then
		local text = matches[2]
tdbot.sendMessage(matches[3], "", 0, text, 0,  "html")
	end

if ((matches[1] == 'sendall' and not Clang) or (matches[1] == "ارسال به همه" and Clang)) and is_sudo(msg) then		
local data = load_data(_config.moderation.data)		
local bc = matches[2]			
for k,v in pairs(data) do				
tdbot.sendMessage(k, "", 0, bc, 0,  "html")
end	
end

  if is_sudo(msg) then
	if ((matches[1]:lower() == "sendfile" and not Clang) or (matches[1] == "ارسال فایل" and Clang)) and matches[2] and matches[3] then
		local send_file = "./"..matches[2].."/"..matches[3]
		tdbot.sendDocument(msg.to.id, send_file, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)
	end
	if ((matches[1]:lower() == "sendplug" and not Clang) or (matches[1] == "ارسال پلاگین" and Clang)) and matches[2] then
	    local plug = "./plugins/"..matches[2]..".lua"
		tdbot.sendDocument(msg.to.id, plug, msg_caption, nil, msg.id, 0, 1, nil, dl_cb, nil)
    end
  end

    if ((matches[1]:lower() == 'save' and not Clang) or (matches[1] == "ذخیره پلاگین" and Clang)) and matches[2] and is_sudo(msg) then
        if tonumber(msg.reply_to_message_id) ~= 0  then
            function get_filemsg(arg, data)
                function get_fileinfo(arg,data)
                    if data.content._ == '`💥messageDocument`\n`Channel:`\n@RadicalBotTeam' then
                        fileid = data.content.document.document.id
                        filename = data.content.document.file_name
						file_dl(document_id)
						sleep(1)
                        if (filename:lower():match('.lua$')) then
                            local pathf = tcpath..'/files/documents/'..filename
                            if pl_exi(filename) then
                                local pfile = 'plugins/'..matches[2]..'.lua'
                                os.rename(pathf, pfile)
								tdbot.sendMessage(msg.to.id, msg.id,1, '<b>Plugin</b> <code>'..matches[2]..'</code> <b>Has Been Saved.</b>', 1, 'html')
                            else
                                tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥This file does not exist. Send file again.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
                            end
                        else
                            tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥This file is not Plugin File.`\n`Channel:`\n@RadicalBotTeam', 1, 'md')
                        end
                    else
                        return
                    end
                end
                tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = data.id }, get_fileinfo, nil)
            end
	        tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = msg.reply_to_message_id }, get_filemsg, nil)
        end
    end

if ((matches[1] == 'sudos' and not Clang) or (matches[1] == "سودو ها" and Clang)) and is_sudo(msg) then
return sudolist(msg)
    end
if ((matches[1] == 'stats' and not Clang) or (matches[1] == "امار" and Clang)) and is_admin(msg) then
return chat_list(msg)
    end
   if ((matches[1]:lower() == 'join' and not Clang) or (matches[1] == "افزودن" and Clang)) and is_admin(msg) and matches[2] then
	   tdbot.sendMessage(msg.to.id, msg.id, 1, '`💥I Invite you in `'..matches[2]..'\n`Channel:`\n@RadicalBotTeam', 1, 'html')
	   tdbot.sendMessage(matches[2], 0, 1, "`💥Admin Joined!`\n`Channel:`\n@RadicalBotTeam", 1, 'html')
    tdbot.addChatMember(matches[2], msg.from.id, 0, dl_cb, nil)
  end
		if ((matches[1] == 'rem' and not Clang) or (matches[1] == "حذف" and Clang)) and matches[2] and is_admin(msg) then
    local data = load_data(_config.moderation.data)
			-- Group configuration removal
			data[tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
			local groups = 'groups'
			if not data[tostring(groups)] then
				data[tostring(groups)] = nil
				save_data(_config.moderation.data, data)
			end
			data[tostring(groups)][tostring(matches[2])] = nil
			save_data(_config.moderation.data, data)
	   tdbot.sendMessage(matches[2], 0, 1, "`💥Group has been removed by admin command`\n`Channel:`\n@RadicalBotTeam", 1, 'html')
    return '`💥Group `'..matches[2]..' `removed`\n`Channel:`\n@RadicalBotTeam'
		end
if ((matches[1] == 'radical' and not Clang) or (matches[1] == "رادیکال" and Clang)) then
return tdbot.sendMessage(msg.to.id, msg.id, 1, _config.info_text, 1, 'html')
    end
if ((matches[1] == 'admins' and not Clang) or (matches[1] == "ادمین ها" and Clang)) and is_admin(msg) then
return adminlist(msg)
    end
     if ((matches[1] == 'leave' and not Clang) or (matches[1] == "خروج از گروه" and Clang)) and is_admin(msg) then
  tdbot.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
   end
     if ((matches[1] == 'autoleave' and not Clang) or (matches[1] == "خروج خودکار" and Clang)) and is_admin(msg) then
local hash = 'auto_leave_bot'
--Enable Auto Leave
     if ((matches[2] == '+' and not Clang) or (matches[2] == "+" and Clang)) then
    redis:del(hash)
   return '`💥Auto leave has been enabled`\n`Channel:`\n@RadicalBotTeam'
--Disable Auto Leave
     elseif ((matches[2] == '-' and not Clang) or (matches[2] == "-" and Clang)) then
    redis:set(hash, true)
   return '`💥Auto leave has been disabled`\n`Channel:`\n@RadicalBotTeam'
--Auto Leave Status
      elseif ((matches[2] == 'status' and not Clang) or (matches[2] == "موقعیت" and Clang)) then
      if not redis:get(hash) then
   return '`💥Auto leave is enable`\n`Channel:`\n@RadicalBotTeam'
       else
   return '`💥Auto leave is disable`\n`Channel:`\n@RadicalBotTeam'
         end
      end
   end


if matches[1] == "leave" and not Clang and is_sudo(msg) then
if not lang then
text = [[
`💥Bot was successfully Got out from the group`
`Channel:`]]..msg_caption
tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'md')
else

text = [[
`💥ربات با موفقیت از گروه خارج شد`
`کانال ما:`]]..msg_caption
tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'md')
end

end
if matches[1] == "خروج از گروه" and Clang and is_sudo(msg) then
if not lang then
text = [[
`💥Bot was successfully Got out from the group`
`Channel:`
@MeGaPluaTeaM]]
tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'md')
else

text = [[
`💥ربات با موفقیت از گروه خارج شد`
`کانال ما:` 
@RadicalBotTeam]]
tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'md')
end

end
end

return { 
patterns = {                                                                   
"^[!/#](leave)$", 
"^(leave)$", 
"^[!/#](config)$", 
"^(config)$", 
"^[!/#](visudo)$", 
"^(visudo)$", 
"^[!/#](desudo)$",
"^(desudo)$",
"^[!/#](sudos)$",
"^(sudos)$",
"^[!/#](visudo) (.*)$", 
"^(visudo) (.*)$", 
"^[!/#](desudo) (.*)$",
"^(desudo) (.*)$",
"^[!/#](setadmin)$", 
"^(setadmin)$", 
"^[!/#](remadmin)$",
"^(remadmin)$",
"^[!/#](admins)$",
"^(admins)$",
"^[!/#](setadmin) (.*)$", 
"^(setadmin) (.*)$", 
"^(remadmin) (.*)$",
"^[!/#](leave)$",
"^(leave)$",
"^[!/#](autoleave) (.*)$", 
"^(autoleave) (.*)$", 
"^[!/#](radical)$",
"^(radical)$",
"^[!/#](creategroup) (.*)$",
"^(creategroup) (.*)$",
"^[!/#](createsuper) (.*)$",
"^(createsuper) (.*)$",
"^[!/#](tosuper)$",
"^(tosuper)$",
"^[!/#](stats)$",
"^(stats)$",
"^[!/#](clean cache)$",
"^(clean cache)$",
"^[!/#](join) (-%d+)$",
"^(join) (-%d+)$",
"^[!/#](rem) (-%d+)$",
"^(rem) (-%d+)$",
"^[!/#](import) (.*)$",
"^(import) (.*)$",
"^[!/#](setname) (.*)$",
"^(setname) (.*)$",
"^[!/#](setusername) (.*)$",
"^(setusername) (.*)$",
"^[!/#](remusername) (.*)$",
"^(remusername) (.*)$",
"^[!/#](markread) (.*)$",
"^(markread) (.*)$",
"^[!/#](send) +(.*) (-%d+)$",
"^(send) +(.*) (-%d+)$",
"^[!/#](sendall) (.*)$",
"^(sendall) (.*)$",
"^[!/#](sendfile) (.*) (.*)$",
"^(sendfile) (.*) (.*)$",
"^[!/#](save) (.*)$",
"^(save) (.*)$",
"^[!/#](sendplug) (.*)$",
"^(sendplug) (.*)$",
"^[!/#](savefile) (.*)$",
"^(savefile) (.*)$",
"^[!/#]([li]nstall)$",
"^([li]nstall)$",
"^[!/#]([Gg]pid)$",
"^([Gg]pid)$",
"^[!/#]([Ee]xpire)$",
"^([Ee]xpire)$",
"^[!/#]([Ee]xpire) (-%d+)$",
"^([Ee]xpire) (-%d+)$",
"^[!/#]([Ee]xpire) (-%d+) (%d+)$",
"^([Ee]xpire) (-%d+) (%d+)$",
"^[!/#]([Ee]xpire) (%d+)$",
"^([Ee]xpire) (%d+)$",
"^[!/#]([Jj]ointo) (-%d+)$",
"^([Jj]ointo) (-%d+)$",
"^[!/#]([Ll]eave) (-%d+)$",
"^([Ll]eave) (-%d+)$",
"^[!/#]([Pp]lan) ([123]) (-%d+)$",
"^([Pp]lan) ([123]) (-%d+)$",
"^[!/#]([Uu]ninstall)$",
"^([Uu]ninstall)$",

	"^(ترفیع گروه)$",
	"^(نصب)$",
	"^(لغو نصب)$",
    "^(حذف) (-%d+)$",	
    "^(خروج از گروه)$",
	"^(سودو ها)$",
	"^(مشخصات)$",
	"^(ساخت گروه) (.*)$",
	"^(ورود به) (-%d+)$",
	"^(ساخت گروه) (.*)$",
	"^(ساخت سوپرگروه) (.*)$",
	"^(ذخیره فایل) (.*)$",
	"^(سودو)$",
	"^(سودو) (.*)$",	
	"^(حذف سودو)$",
	"^(حذف سودو) (.*)$",	
	"^(تنظیم ادمین)$",
	"^(حذف ادمین)$",
	"^(حذف ادمین) (.*)$",
	"^(ارسال فایل) (.*)$",
	"^(حذف یوزرنیم) (.*)$",
    "^(تغییر یوزرنیم) (.*)$",
	"^(تغییر نام) (.*)$",
	"^(تبدیل به سوپرگروه)$",
	"^(ارسال به همه) (.*)$",
	"^(امار)$",
	"^(خروج از گروه)$",
	"^(خروج از گروه) (-%d+)$",	
	"^(ارسال پلاگین) (.*)$",
	"^(ادمین ها)$",
	"^(خروج خودکار) (.*)$",
    "^(انقضا) (-%d+) (%d+)$",
    "^(انقضا) (%d+)$",	
    "^(پلن) ([123]) (-%d+)$",
    "^(انقضا)$",
    "^(انقضا) (-%d+)$",
    "^(ذخیره پلاگین) (.*)$",
    "^(تیک دوم) (.*)$",
    "^(ارسال) +(.*) (-%d+)$",
	"^(افزودن) (-%d+)$",
	"^(پاکسازی حافظه)$",
	"^(رادیکال)$",
}, 
run = run, pre_process = pre_process
}
-- #End By @RadicalBotTeam
