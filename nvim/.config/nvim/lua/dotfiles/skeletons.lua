local augroup = vim.api.nvim_create_augroup('dotfiles_skeletons', { clear = true })

local skeletons = {
  {
    pattern = '*Test.php',
    snippet = [[
<?php

declare(strict_types=1);

namespace $1;

use PHPUnit\Framework\TestCase;

final class $TM_FILENAME_BASE extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
    }

    public function test$2(): void
    {
        $0
    }
}]],
  },
  {
    pattern = '*.php',
    snippet = [[
<?php

declare(strict_types=1);

namespace $1;

final class $TM_FILENAME_BASE
{
    $0
}]],
  },
  {
    pattern = '*_test.go',
    snippet = [[
package $TM_DIRECTORY

import "testing"

func Test$1(t *testing.T) {
	$0
}]],
  },
  {
    pattern = '*.go',
    snippet = [[
package $TM_DIRECTORY

$0]],
  },
}

for _, skeleton in ipairs(skeletons) do
  vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = augroup,
    pattern = skeleton.pattern,
    desc = 'Skeleton for ' .. skeleton.pattern .. ' files',
    callback = function(args)
      local lines = vim.api.nvim_buf_get_lines(args.buf, 0, 2, false)
      if #lines > 1 or lines[1] ~= '' then
        return
      end
      if vim.b[args.buf].skeleton_is_applied ~= nil then
        return
      end
      vim.snippet.expand(skeleton.snippet)
      vim.b[args.buf].skeleton_is_applied = skeleton.pattern
    end,
  })
end
