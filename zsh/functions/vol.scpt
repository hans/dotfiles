on run argv
   set cur to output volume of (get volume settings)
   set delta to item 1 of argv
   set volume output volume ( cur + delta )
end run