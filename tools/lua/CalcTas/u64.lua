local function zero()
    local num = {}
    -- 20 digit + carry digit
    for i = 1, 21, 1 do
        num[i] = 0
    end
    return num
end

local function int(u32)
    local num = zero()
    local str = ("%u"):format(u32)
    for i= 1, #str, 1 do
        num[i] = tonumber(str:sub(-i, -i))
    end
    return num
end

local function carry(num)
    for i = 1, 20, 1 do
        while num[i] >= 10 do
            num[i] = num[i] - 10
            num[i+1] = num[i+1] + 1
        end
    end
    return num
end

local function double(num)
    for i = 1, 20, 1 do
        num[i] = num[i] * 2
    end
    carry(num)
    return num
end

local function toHigh(num)
    for i = 1, 32, 1 do
        double(num)
    end
    return num
end

local function concatHighLow(high, low)
    local num = {}
    for i = 1, 20, 1 do
        num[i] = low[i]
    end
    for i = 1, 20, 1 do
        num[i] = num[i] + high[i]
    end
    return carry(num)
end

local function u64toDecString(u32High, u32Low)
    local high = toHigh(int(u32High))
    local low = int(u32Low)
    local num = concatHighLow(high, low)

    local str = ""
    local top = 20
    while num[top] == 0 do
        top = top - 1
        if top == 0 then
            return nil
        end
    end
    for i=top, 1, -1 do
        str = str .. tostring(num[i])
    end
    return str
end

local function hex2dec(str)
    local pat = "[^0-9ABCDEFabcdef]"
    str = str:gsub(pat, "")
    if #str == 0 then
        return nil
    end
    local high, low
    if #str <= 8 then
        high = 0
        low = tonumber(str:sub(-8,-1), 16)
    else
        high = tonumber(str:sub(1,-9), 16)
        low = tonumber(str:sub(-8,-1), 16)
    end
    return u64toDecString(high, low)
end

return hex2dec
-- test
-- print(u64toDecString(0x12345678,0x90123456) == "1311768467284833366")
