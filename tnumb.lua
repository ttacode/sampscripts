SCRIPT_VERSION =  "2.8"

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
2824097,
603,
111911,
2826541,
455555,
166665,
686666,
47,
211,
40,
125125,
2825415,
2825850,
252550,
2705882,
910910,
808080,
1515,
661453,
345677,
5557,
2823996,
215,
153153,
707555,
733337,
7007,
2826759,
1010,
6663,
9909,
9292,
898,
350035,
474,
2801665,
770,
7071,
9874,
49,
666777,
13,
158888,
2709983,
1153277,
51,
986898,
330330,
344,
4777,
75,
400,
774,
113311,
212,
9200,
2107233,
464444,
776677,
2786199,
1221,
2775306,
555050,
86,
773,
1101,
2714287,
120,
196,
580022,
295,
222201,
225588,
555655,
700001,
7799,
15,
570,
3113,
91,
557,
31,
79,
8800,
888,
202021,
6104,
111151,
1234,
1191,
690,
747,
170602,
106,
440,
101011,
371,
2826267,
7300,
111119,
444441,
138138,
4500,
507777,
219999,
2798554,
2826008,
900,
1911,
1600,
661,
7111,
3737,
1551,
299999,
937999,
112,
335,
552,
250007,
7272,
9095,
769,
3636,
830000,
2546775,
100001,
966969,
570773,
8811,
332,
2372927,
2000197,
80,
2795719,
111011,
2551343,
1337,
431,
716,
4090,
2710491,
57,
2637693,
338822,
5792,
866666,
1555,
114433,
662662,
555888,
3877,
770770,
152200,
2818267,
878888,
404040,
2612264,
987,
2727,
1202,
2817050,
5115,
2811479,
247,
971999,
228,
152,
775677,
3321,
6789,
801080,
1281997,
2825188,
2232,
2155888,
959959,
2825083,
2823651,
221822,
2825582,
939393,
990799,
2811609,
2803349,
88
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
	sampSendChat('/sms ' .. findValue[znach] .. ' tasks')
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
