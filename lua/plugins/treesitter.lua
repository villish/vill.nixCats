local uv = vim.loop
local parser_install_dir = vim.fn.stdpath 'data' .. '/treesitter'
local treesitter_dir = nixCats.pawsible.allPlugins.start['nvim-treesitter.withAllGrammars'] or nixCats.pawsible.allPlugins.start['nvim-treesitter']

local function stat(path)
  local ok, result = pcall(uv.fs_lstat, path)
  if ok then
    return result
  end
end

local function readlink(path)
  local ok, result = pcall(uv.fs_readlink, path)
  if ok then
    return result
  end
end

local function populate_parser_dir()
  if not treesitter_dir then
    return
  end

  local store_parser_dir = treesitter_dir .. '/parser'
  if vim.fn.isdirectory(store_parser_dir) == 0 then
    return
  end

  vim.fn.mkdir(parser_install_dir, 'p')

  local handle = uv.fs_scandir(store_parser_dir)
  if not handle then
    return
  end

  while true do
    local name = uv.fs_scandir_next(handle)
    if not name then
      break
    end

    local src = store_parser_dir .. '/' .. name
    local dest = parser_install_dir .. '/' .. name
    local dest_stat = stat(dest)
    local keep = dest_stat and dest_stat.type == 'link' and readlink(dest) == src

    if not keep then
      if dest_stat then
        pcall(uv.fs_unlink, dest)
      end

      local link_ok, link_res = pcall(uv.fs_symlink, src, dest)
      if not link_ok or link_res == false then
        pcall(uv.fs_copyfile, src, dest)
      end
    end
  end
end

return {
  vim.tbl_extend('force', {
    'nvim-treesitter/nvim-treesitter',
    init = function()
      populate_parser_dir()
      require('nvim-treesitter.install').parser_install_dir = parser_install_dir
      if not vim.tbl_contains(vim.opt.runtimepath:get(), parser_install_dir) then
        vim.opt.runtimepath:append(parser_install_dir)
      end
    end,
    opts = function(_, opts)
      opts.parser_install_dir = parser_install_dir
      return opts
    end,
  }, treesitter_dir and { dir = treesitter_dir } or {}),
}
