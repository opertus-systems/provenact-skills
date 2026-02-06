(module
  (func (export "run") (result i32)
    (local $x i32)
    (local $i i32)
    i32.const 88
    local.set $x
    i32.const 10
    local.set $i
    block $done
      loop $loop
        local.get $i
        i32.eqz
        br_if $done
        local.get $x
        i32.const 43
        i32.mul
        i32.const 2
        i32.add
        local.set $x
        local.get $i
        i32.const 1
        i32.sub
        local.set $i
        br $loop
      end
    end
    local.get $x
    i32.const 2147483647
    i32.and
  )
)
