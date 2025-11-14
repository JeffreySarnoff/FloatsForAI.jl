module AssignSym
export @assign

"""
    @assign(symexpr, val)

Assign `val` to the variable named by `symexpr`.

- `@assign(:x, v)` → `x = v`
- `@assign(x, v)`:
    * If `x` is bound (as a global) to a `Symbol` at macro-expansion time,
      assign to that symbol (e.g. `this_symbol = v` when `x == :this_symbol`).
    * Otherwise assign to `x` itself.
- `@assign(expr, v)` where `expr` evaluates (at macro-expansion) to a `Symbol`
  → assign to that symbol.

Note: macros cannot create/assign locals whose names are only known at runtime.
"""
macro assign(symexpr, val)
    # Case 1: literal :name
    if symexpr isa Base.QuoteNode && symexpr.value isa Symbol
        return Expr(:(=), esc(symexpr.value), esc(val))
    end

    # Case 2: bare identifier
    if symexpr isa Symbol
        # If the identifier is a global that currently holds a Symbol, use that
        if Base.isdefined(__module__, symexpr)
            local v = Base.eval(__module__, symexpr)
            if v isa Symbol
                return Expr(:(=), esc(v), esc(val))
            end
        end
        # Otherwise, assign to the identifier itself
        return Expr(:(=), esc(symexpr), esc(val))
    end

    # Case 3: general expression that should evaluate to a Symbol at expansion
    local s = Base.eval(__module__, symexpr)
    s isa Symbol || error("@assign: first argument must be or evaluate to a Symbol; got $(repr(s))")
    return Expr(:(=), esc(s), esc(val))
end

#=
using .AssignSym

# A) bare name
@assign varname (1, 'a')
@assert varname == (1, 'a')

# B) literal symbol
@assign :x 42
@assert x == 42

# C) identifier bound to a Symbol (expansion-time)
asymbol = :this_symbol
val = (1, 'a')
@assign asymbol val
@assert this_symbol == val
=#
end # module

using .AssignSym

