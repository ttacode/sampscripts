SCRIPT_VERSION =  "1.1"

local sampev = require("lib.samp.events")

local requests = require("requests")

require "moonloader"
local encoding = require "encoding"
encoding.default = "CP1251"
u8 = encoding.UTF8

local bn = 0
local ln = 0
local sn = 0
local sdelay = 990

local findValue = {}

local dopValue = {
88,
1315,
101018,
990799,
776677,
733337,
773,
121,
116666,
75,
51,
774777,
140000,
355555,
555050,
898,
1010,
86,
4944,
9871,
770,
313133,
122222,
1050,
555999,
330330,
953,
111120,
400005,
7799,
9876,
66,
5677,
15,
9095,
341,
343,
9874,
196,
555565,
580022,
312,
120,
158888,
993,
2800,
557,
344,
808080,
455555,
603,
201369,
707,
7010,
211,
219999,
111119,
143143,
828888,
350035,
570773,
101011,
666666,
690,
205555,
127,
4060,
111162,
878,
1811,
31,
464444,
775677,
441,
1600,
299999,
234,
1551,
765123,
333302,
3321,
112,
543,
551,
3737,
123,
335,
7535,
5792,
966969,
44,
152200,
716,
111011,
111411,
500050,
314,
1191,
1190,
877,
444441,
440,
525777,
1911,
240444,
2242,
885,
3636
}

local numberValue = {
119,
121,
127,
314,
343,
440,
474,
557,
603,
690,
716,
773,
898,
902,
904,
953,
987,
993,
1101,
1337,
2727,
3033,
3999,
4060,
4090,
4434,
5792,
6663,
7010,
9200,
9871,
9876,
100050,
111911,
112244,
123888,
152200,
180180,
200107,
200197,
201369,
210012,
215216,
300333,
313133,
321321,
333002,
420420,
445445,
464444,
484444,
500050,
500355,
545545,
555502,
555565,
609060,
654321,
662664,
666156,
666187,
666666,
717777,
737777,
855558,
866666,
888188,
966969,
990199,
992999,
999999
}


local function checkForUpdate()
    local ok, res = pcall(function()
        return requests.get(VERSION_URL)
    end)

    if not ok or not res or res.status_code ~= 200 then
        return
    end

    local remoteVersion = res.text:gsub("%s+", "")
    if remoteVersion == SCRIPT_VERSION then
        return
    end

    sampAddChatMessage(
        string.format("[Updater] Найдена новая версия: %s (у тебя %s)",
        remoteVersion, SCRIPT_VERSION),
        -1
    )

    local file = requests.get(UPDATE_URL)
    if not file or file.status_code ~= 200 then
        sampAddChatMessage("[Updater] Ошибка загрузки файла", -1)
        return
    end

    local f = io.open(thisScript().path, "w")
    if not f then
        sampAddChatMessage("[Updater] Не удалось перезаписать файл", -1)
        return
    end

    f:write(u8:decode(file.text))
    f:close()

    sampAddChatMessage("[Updater] Скрипт обновлён, перезагрузка...", -1)
    thisScript():reload()
end

function main()
  repeat wait(0) until isSampAvailable()
  sampRegisterChatCommand("tnumb", cmd_tnumb)
  sampRegisterChatCommand("lnumb", cmd_lnumb)
  sampRegisterChatCommand("snumb", cmd_snumb)
  sampRegisterChatCommand("smsdelay", cmd_smsdelay)
	sampRegisterChatCommand("update", checkForUpdate)
	while not isSampAvailable() do wait(100) end
end



function sampev.onShowDialog(id, style, title, b1, b2, text)

if title:find('Сотрудники онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('.*_.*[%d+].*%d+.*{99b3ff}%d+') then
tnumber = line:match('.*_.*[%d+].*%d+.*{99b3ff}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end

if title:find('Врачи онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('{00e6ac}%d+') then
tnumber = line:match('{00e6ac}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end

if title:find('Лицензеры онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('{00e6ac}%d+') then
tnumber = line:match('{00e6ac}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end

if title:find('Адвокаты онлайн') and bn == 1 then
findValue = {}
	for line in text:gmatch("[^\n]+") do
if line:find('{00e6ac}%d+') then
tnumber = line:match('{00e6ac}(%d+)')
tnumber = tonumber(tnumber)
table.insert(findValue, tnumber)
end
end
tnumb()
end
end



function tnumb()
lua_thread.create(function()
znach = 0
	for i = 0, 1000 do
		znach = znach + 1
		if not findValue[znach] or bn == 0 then
			break
		end
	sampSendChat('/sms ' .. findValue[znach] .. ' tasks')
		wait(sdelay)
	end
end)
end

function lnumb()
lua_thread.create(function()
znach = 0
	for i = 0, 1000 do
		znach = znach + 1
		if not numberValue[znach] or ln == 0 then
			break
		end
	sampSendChat('/sms ' .. numberValue[znach] .. ' tasks')
		wait(sdelay)
	end
end)
end

function snumb()
lua_thread.create(function()
znach = 0
	for i = 0, 1000 do
		znach = znach + 1
		if not dopValue[znach] or sn == 0 then
			break
		end
	sampSendChat('/sms ' .. dopValue[znach] .. ' tasks')
		wait(sdelay)
	end
end)
end

function cmd_tnumb(arg)
	if bn == 0 then
		bn = 1
		printStringNow('TASK NUMBERFIND ON', 1000)
	else
		bn = 0
		printStringNow('TASK NUMBERFIND OFF', 1000)
	end
end

function cmd_lnumb(arg)
	if ln == 0 then
		ln = 1
		lnumb()
		printStringNow('TASK NUMBERLIST ON', 1000)
	else
		ln = 0
		printStringNow('TASK NUMBERLIST OFF', 1000)
	end
end

function cmd_snumb(arg)
	if sn == 0 then
		sn = 1
		snumb()
		printStringNow('TASK FRESHNUMBER ON', 1000)
	else
		sn = 0
		printStringNow('TASK FRESHNUMBER OFF', 1000)
	end
end


function cmd_smsdelay(param)
		if tonumber(param) ~= nil then
			param = tonumber(param)
				if param < 500 or param > 5000 then
					sampAddChatMessage("Укажи корректную задержку (500-5000)", -1)
				else
					sampAddChatMessage('Delay '.. param .. ' ms', -1)
					sdelay = param
				end
		else
			sampAddChatMessage("Укажи задержку", -1)
		end
end
