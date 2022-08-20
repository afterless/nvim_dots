local M = {}

local venv = os.getenv("CONDA_PREFIX")

M.adapters = {
    type = 'executable',
    command = string.format("%s/bin/python", venv),
    args = { '-m', 'debugpy.adapter' },
}

M.configuration = {
    {
        type = 'python',
        request = 'launch',
        name = "Launch file",

        program = "${file}",
        pythonPath = function()
            return string.format("%s/bin/python", venv)
        end,
    }
}

return M
