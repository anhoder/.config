return {
  "anhoder/hbac.nvim",
  opts = {
    autoclose = true,
    threshold = 2,
    reserved_unedited_num = 0,
    close_command = function(n)
      require("mini.bufremove").delete(n, false)
    end,
  },
}
