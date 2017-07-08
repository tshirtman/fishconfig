function python
	if set -q VIRTUAL_ENV
		eval (which python) $argv
	else
		eval python(math (random)%2+2) $argv
	end
end
