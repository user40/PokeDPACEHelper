local hex2dec = require("u64")
----------------------------------
-- Utility
----------------------------------
local function iterFactory(x)
    local pos = 0
    local length = #x
    return function()
        pos = pos + 1
        if pos > length then
            return nil
        else
            return x[pos]
        end
    end
end

----------------------------------
-- Button
----------------------------------
local buttons = {
    -- constants
    duration = {stylus=2, button=2},
    topLeft = {x=45, y=60},
    buttonWidth = 33,
}
buttons.pos = {
    key0 = {"stylus", 0, 3},
    key1 = {"stylus", 0, 2},
    key2 = {"stylus", 1, 2},
    key3 = {"stylus", 2, 2},
    key4 = {"stylus", 0, 1},
    key5 = {"stylus", 1, 1},
    key6 = {"stylus", 2, 1},
    key7 = {"stylus", 0, 0},
    key8 = {"stylus", 1, 0},
    key9 = {"stylus", 2, 0},
    keyDot = {"stylus", 2, 3},
    keyC = {"stylus", 3, 0},
    keyAdd = {"stylus", 3, 1},
    keySub = {"stylus", 4, 1},
    keyMul = {"stylus", 3, 2},
    keyDiv = {"stylus", 4, 2},
    keyEq = {"stylus", 3, 3},
    keyX = {"button", "X"},
    keyY = {"button", "Y"},
    keyA = {"button", "A"},
    keyB = {"button", "B"},
    keyL = {"button", "L"},
    keyR = {"button", "R"},
    keyStart = {"button", "start"}
}

function buttons:click(key)
    if key == "nop" or key == nil then
        return
    end

    local pos = buttons.pos[key]
    if pos[1] == "stylus" then
        buttons.touch(pos)
    else
        buttons.push(pos)
    end
end

function buttons.push(pos)
    local tbl = {}
    tbl[pos[2]] = true
    joypad.set(tbl)
end

function buttons.touch(pos)
    local x = buttons.topLeft.x + pos[2] * buttons.buttonWidth
    local y = buttons.topLeft.y + pos[3] * buttons.buttonWidth
    stylus.write({x=x, y=y, touch=true})
end

----------------------------------
-- Interpreter
----------------------------------
local interpreter = {
    mode = {retire=nil, retireA=nil, eq=nil, dot=nil}
}
interpreter.dict = {
    ["1"] = "key1",
    ["2"] = "key2",
    ["0"] = "key0",
    ["3"] = "key3",
    ["4"] = "key4",
    ["5"] = "key5",
    ["6"] = "key6",
    ["7"] = "key7",
    ["8"] = "key8",
    ["9"] = "key9",
    ["."] = "keyDot",
    ["C"] = "keyC",
    ["+"] = "keyAdd",
    ["-"] = "keySub",
    ["*"] = "keyMul",
    ["/"] = "keyDiv",
    ["="] = "keyEq",
    ["A"] = "keyA",
    ["B"] = "keyB",
    ["X"] = "keyX",
    ["Y"] = "keyY",
    ["L"] = "keyL",
    ["R"] = "keyR",
    ["n"] = "nop",
}

function interpreter:init()
    self.mode = {
        retire=nil,
        retireA=nil,
        plusZero=nil,
        eq=nil,
        dot=nil,
        singleNumber=nil,
    }
end

function interpreter:toKeys(line)
    if self:isComment(line) or line == "" then
        return
    end

    local mode = self:checkModeChange(line)
    if mode then
        self:changeMode(mode)
        return nil
    end

    line = self:preProcess(line)
    local result = self:interpret(line)
    return iterFactory(self:twice(result))
end

function interpreter:interpret(line)
    local pat = "[^0-9%.C%+%-%*%/%=ABXYn]"
    line = line:gsub(pat, "")

    local result = {}
    for i = 1, #line, 1 do
        local char = string.sub(line,i,i)
        result[2*i - 1] = interpreter.dict[char]
        result[2*i - 0] = "nop"
    end
    return result
end

function interpreter:isComment(line)
    if line:sub(1, 1) == "#" then
        return true
    else
        return false
    end
end

function interpreter:checkModeChange(line)
    local isChangeMode = (line:sub(1, 4) == "MODE")
    if not isChangeMode then
        return nil
    end

    local contents = line:sub(5,-1)
    local mode = {}
    for v in string.gmatch(contents, "[^%s]+") do
        mode[v] = true
    end
    return mode
end

function interpreter:changeMode(mode)
    self.mode = mode
end

function interpreter:preProcess(line)
    if self.mode.hex then
        line = hex2dec(line)
        if not line then
            return nil
        end
    end
    if self.mode.plusZero then
        line = line .. "+0"
    end
    if self.mode.eq then
        line = line .. "="
    end
    if self.mode.singleNumber then
        line = line .. "+0="
    end
    if self.mode.retire then
        line = line .. "XnA"
    end
    if self.mode.retireA then
        line = line .. "XnAA"
    end
    if self.mode.dot then
        line = line .. ".C"
    end
    return line
end

-- {a, b, c} -> {a, a, b, b, c, c}
function interpreter:twice(list)
    local result = {}
    for i, v in ipairs(list) do
        result[i*2 - 1] = v
        result[i*2 - 0] = v
    end
    return result
end

----------------------------------
-- Clicker
----------------------------------
local clicker = {
    isDone = false,
    lines = nil,
    key = nil,
}

function clicker:init(filePath)
    self.isDone = false
    self.lines = io.lines(filePath)
    clicker:setNewLine()
end

function clicker:setNewLine()
    while true do
        local line = self.lines()
        if not line then
            self.isDone = true
            return
        end

        self.keys = interpreter:toKeys(line)
        if self.keys then
            return
        end
    end
end

function clicker:click()
    if self.isDone then
        return
    end

    local key = self.keys()
    if key == nil then
        self:setNewLine()
        if self.isDone then
            return
        end
        key = self.keys()
    end
    buttons:click(key)
end


return clicker