return function()
  require('renamer').setup({
	  -- The popup title, shown if `border` is true
	  title = "Rename",
	  -- The padding around the popup content
	  padding = {
		  top = 0,
		  left = 0,
		  bottom = 0,
		  right = 0,
	  },
	  -- Whether or not to shown a border around the popup
	  border = true,
	  -- Whether or not to highlight the current word references through LSP
	  show_refs = true,
	  -- The keymaps available while in the `renamer` buffer. The example below
	  -- overrides the default values, but you can add others as well.
	  mappings = {
		  ["<c-i>"] = require("renamer.mappings.utils").set_cursor_to_start,
		  ["<c-a>"] = require("renamer.mappings.utils").set_cursor_to_end,
		  ["<c-e>"] = require("renamer.mappings.utils").set_cursor_to_word_end,
		  ["<c-b>"] = require("renamer.mappings.utils").set_cursor_to_word_start,
		  ["<c-c>"] = require("renamer.mappings.utils").clear_line,
		  ["<c-u>"] = require("renamer.mappings.utils").undo,
		  ["<c-r>"] = require("renamer.mappings.utils").redo,
	  },
  })
end
