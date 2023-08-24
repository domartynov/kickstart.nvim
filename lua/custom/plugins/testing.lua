-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	"nvim-neotest/neotest",
  dependencies = {
    'nvim-neotest/neotest-go',
  },
  keys = {
    { "<leader>tn", function () require("neotest").run.run() end, desc = "Run nearest test"},
    { "<leader>td", function () require("neotest").run.run({strategy = "dap"}) end, desc = "Debug nearest test"},
    { "<leader>tf", function () require("neotest").run.run(vim.fn.expand("%")) end, desc = "Test file"},
    { "<leader>ts", function () require('neotest').run.run(vim.fn.getcwd()) end, desc = "Test directory"},
    { "<leader>te", function () require('neotest').summary.toggle() end, desc = "Toggle test summary"},
  },
  config = function()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message =
            diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)
    require("neotest").setup({
      -- your neotest config here
      adapters = {
        require("neotest-go"),
      },
    })
  end,
}

-- vim: ts=2 sts=2 sw=2 et
