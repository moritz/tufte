use v6;
class Tufte::Graph;
use Tufte::GraphState;

has $!internal-state handles <
            title theme default-type
            point-markers value-formatter raterizer
        > = Tufte::GraphState.new;

has $.renderer is rw handles <component remove>;



# vim: ft=perl6 sw=4 ts=4 expandtab
