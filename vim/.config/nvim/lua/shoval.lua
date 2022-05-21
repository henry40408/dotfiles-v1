-- shoves all those files into three directories, rather than individual local project directories
-- ref: https://sts10.github.io/2016/02/13/best-of-my-vimrc.html

local sf = string.format
local c = vim.call
local o = vim.opt
local h = os.getenv('HOME')

c('system', sf('mkdir -p %s/.vim/backup', h))
o.backupdir = sf([[%s/.vim/backup]], h)

c('system', sf('mkdir -p %s/.vim/swap', h))
o.directory = sf([[%s/.vim/swap]], h)

local d = sf('%s/.vim/undo', h)
c('system', sf('mkdir -p %s', d))
o.undodir = d
o.undofile = true
o.undolevels = 1000
o.undoreload = 1000
