-module (forget).
-compile(export_all).

main() ->
    Foo = foo,
    shell_default:f(),
    Foo = bar.
