--- @since 25.5.31
-- git-repos.yazi
--
-- Marks subdirectories that are git repositories, in the linemode column.
-- A clean repo shows a dim git glyph; a repo with uncommitted or untracked
-- changes shows the same glyph highlighted. This complements the official
-- `git` plugin, which only renders file status *inside* a single repo and
-- shows nothing when the current dir (e.g. ~/.local/src) is not itself a repo.

-- Per-directory status codes kept in plugin state.
local NONE  = 0 -- not a git repo, no marker
local CLEAN = 1 -- git repo, working tree clean
local DIRTY = 2 -- git repo, uncommitted or untracked changes

-- Tunables. SIGN is the repo marker; swap for a nerd-font glyph if you prefer.
local SIGN     = "●"
local CLEAN_FG = "darkgray"
local DIRTY_FG = "yellow"

---@param dir Url
---@return integer
local function status_of(dir)
	-- Cheap gate: only spend a git call on dirs that actually contain `.git`
	-- (a dir for a normal repo, a file for a worktree / submodule).
	if not fs.cha(dir:join(".git")) then
		return NONE
	end

	-- stylua: ignore
	local output = Command("git")
		:cwd(tostring(dir))
		:arg({ "--no-optional-locks", "status", "--porcelain", "-unormal" })
		:stdout(Command.PIPED)
		:output()

	if not output then
		return CLEAN -- it is a repo; assume clean if git could not run
	end
	return output.stdout ~= "" and DIRTY or CLEAN
end

local set = ya.sync(function(st, dir, code)
	st.repos = st.repos or {}
	if st.repos[dir] ~= code then
		st.repos[dir] = code
		if ui.render then
			ui.render()
		else
			ya.render()
		end
	end
end)

local get = ya.sync(function(st, dir)
	return st.repos and st.repos[dir] or NONE
end)

---@param st State
local function setup(st, _)
	st.repos = {}

	Linemode:children_add(function(self)
		local code = get(tostring(self._file.url))
		if code == NONE then
			return ""
		elseif self._file.is_hovered then
			return ui.Line { " ", SIGN }
		end
		local fg = code == DIRTY and DIRTY_FG or CLEAN_FG
		return ui.Line { " ", ui.Span(SIGN):fg(fg) }
	end, 1400)
end

---@type UnstableFetcher
local function fetch(_, job)
	for _, file in ipairs(job.files) do
		if file.cha.is_dir then
			set(tostring(file.url), status_of(file.url))
		end
	end
	return false
end

return { setup = setup, fetch = fetch }
