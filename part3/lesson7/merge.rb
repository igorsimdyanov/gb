first = { fst: 1, snd: 2 }
second = { fst: :hello, thd: :world }

p first.merge second # {:fst=>:hello, :snd=>2, :thd=>:world}
