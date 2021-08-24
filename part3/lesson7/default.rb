h = {}
p h.default # nil
p h[:hello] # nil

h.default = 42
p h.default
p h[:hello]
