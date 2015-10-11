-module (reverse).
-export ([rev/1]).

rev([A | [B | Rest]]) -> rev(Rest) ++ [B, A];
rev([X]) -> [X];
rev([]) -> [] .
