local M = {}
local cmd = vim.cmd

function M.create_augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, autocmd in ipairs(autocmd) do 
        cmd('autocmd' .. table.concat(autocmd, ' '))
    end
    cmd('autocmd END')
end

function M.conditional(condition, trueValue, falseValue)
	if (condition) then
		return trueValue
	else
		return falseValue
	end
end

function M.custom_on_attach(client)
	print('Attaching to' .. client.name)
	completion.on_attach(client)
end

return M
