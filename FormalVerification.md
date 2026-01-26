# Assertions

## Concurrent Assertions

Syntax:

```
assertion_tag: assert property ( @(posedge clk) disable iff (!reset)
                                (rd_en_i & !empty) |=> (counter == $past(counter) + 1);
);
```

```

No ```$error``` message is needed, there is a default one. For personalize error messages you do have to use ```else $error ("blabla")```