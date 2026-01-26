# Assertions
The tool must check the property is always true.

## Concurrent Assertions

Syntax:

```
assertion_tag: assert property ( @(posedge clk) disable iff (!reset)
                                (rd_en_i & !empty) |=> (counter == $past(counter) + 1);
);
```
No ```$error``` message is needed, there is a default one. For personalize error messages you do have to use ```else $error ("blabla")```


Using a costume ```$error``` message:

```
assertion_tag: assert property ( @(posedge clk) disable iff (!reset)
                                (!wr_en_i & empty) |=> (counter == $past(counter))
    else 
        $error("Counter increased instead of staying as it should");
);
```

## Operators:

- $rose
- $past(expression, num_cycles)
- $stable
- $countones
- $onehot
- $onehot0
- $isunknown

- |-> = overlapping implicator - verifies in the same clock cycle.

- |=> = non-overlapping implicator - evaluates in the next clock cycle

- ##n ##[m:n] delay operators


