local M = {}

--- Parse errors from rustc output
---@param output string
---@return neotest.Error[]
function M.parse_errors(output)
    if output == nil then
        return {}
    end

    local message, line = output:match("thread '[^']+' panicked at '([^']+)', [^:]+:(%d+):%d+")

    if message == nil then
        -- Try a different expression
        _, line, message = output:match("thread '[^']+' panicked at ([^:]+):(%d+):[^:]+:\n([^\n]*)")
    end

    -- If we can't parse the output, return an empty table
    if message == nil then
        return {}
    end

    -- Note: we have to return the line index, not the line number
    return {
        { line = tonumber(line) - 1, message = message },
    }
end

return M
