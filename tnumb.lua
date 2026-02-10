SCRIPT_VERSION =  "3.3"

local sampev = require("lib.samp.events")

local requests = require("requests")

require "moonloader"
local encoding = require "encoding"
encoding.default = "CP1251"
u8 = encoding.UTF8
local function safeDecode(str)
    if str and type(str) == "string" then
        return u8:decode(str)
    else
        return ""
    end
end

title = safeDecode(title)

local bn = 0
local ln = 0
local sn = 0
local sdelay = 990

local UPDATE_URL = "https://raw.githubusercontent.com/ttacode/sampscripts/refs/heads/main/tnumb.lua"
local VERSION_URL = "https://raw.githubusercontent.com/ttacode/sampscripts/refs/heads/main/version.txt"

local findValue = {}

local dopValue = {
966969,
280400,
31,
79,
2542854,
158888,
330330,
7373,
8800,
211414,
505050,
911000,
8788,
303003,
10,
444440,
1022,
5115,
2714287,
2826835,
1592107,
717777,
1050,
9008,
2710225,
25,
898,
779,
939,
78,
200000,
911999,
1829438,
2709983,
992999,
776777,
89,
258644,
7273,
2827310,
3333,
9697,
38,
555655,
1101,
202021,
884488,
466,
211771,
113311,
343,
9333,
7071,
75,
7977,
522222,
466542,
220203,
9999,
4944,
4474,
15,
4070,
541111,
570,
7799,
444,
4989,
700007,
151,
1921860,
2775306,
788888,
464444,
2821837,
4001,
2828811,
202015,
370,
6866,
4222,
5333,
299999,
707,
2828006,
2813323,
2363263,
2817687,
888448,
2828973,
910910,
2815799,
830000,
111911,
733333,
100,
690,
2805,
225533,
3030,
769,
777333,
507777,
3033,
777,
552,
661453,
49,
2232,
1900,
3737,
1517,
660,
888,
920,
543,
500493,
1600,
112,
828888,
100002,
359822,
107,
1551,
400,
99,
101011,
1155,
2546775,
86,
234,
116611,
3636,
2688251,
341,
332,
321132,
446444,
295000,
16,
123,
232425,
2749992,
952,
2823828,
123434,
7272,
494,
1141,
884,
383838,
132611,
885,
2828621,
567,
555888,
2828695,
111119,
1315,
2811479,
1910,
7535,
227722,
2305964,
44,
70,
1845385,
2799221,
2802312,
1462122,
560,
3321,
6789,
224444,
2105398,
554450,
2210,
9200,
2333,
2805430,
2821991,
2337709,
666666,
312,
2827311,
2823859,
371,
600700,
2829010,
848584,
2813775,
1515,
2826817,
40,
2717203,
7010,
2828697,
4466,
127,
7007,
138138,
2829118,
1555,
4308,
119,
666626,
2810769,
2030,
904,
232,
2827273,
2817220,
441,
2813178,
2330,
4141,
51,
345,
111151,
878888,
700001,
5757,
2827758,
110001,
2687087,
27,
616,
9790,
559,
88,
776677,
138877,
2888,
111411
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
		sampAddChatMessage("[TNUMB] Обновление не найдено", 0xA9A9A9)
        return
    end

    sampAddChatMessage("[TNUMB] Найдена свежая версия", 0x00FFCC)

    local file = requests.get(UPDATE_URL)
    if not file or file.status_code ~= 200 then
        sampAddChatMessage("[TNUMB] Ошибка загрузки файла", 0xA9A9A9)
        return
    end

    local f = io.open(thisScript().path, "w")
    if not f then
        sampAddChatMessage("[TNUMB] Не удалось перезаписать файл", 0xA9A9A9)
        return
    end

    f:write(u8:decode(file.text))
    f:close()

    sampAddChatMessage("[TNUMB] Скрипт обновлён, перезагрузка...", 0x00FFCC)
    thisScript():reload()
end

function main()
  repeat wait(0) until isSampAvailable()
  sampRegisterChatCommand("tnumb", cmd_tnumb)
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
	sampSendChat('/sms ' .. findValue[znach] .. ' task')
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
	sampSendChat('/sms ' .. dopValue[znach] .. ' task')
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
