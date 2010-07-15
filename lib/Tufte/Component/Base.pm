class Tufte::Component::Base;
use SVG::State;

has $.id;
has @.position is rw = (0, 0);
has @.size is rw = (100, 100);
has %.options is rw;
has $.visible is rw = True;
has $!render_height;
has $!svg = SVG::State.new;

multi method render(%bounds, %options) {
    return unless $!visible;
    %options = %options, %.options;

    return $.process(%options) unless %bounds;

    $!render_height = %bounds<height>;

    $!svg.drawings = :g[:$!id,
        :transform("translate(%bounds.delete('x'), %bounds.delete('y'))"),
        $.draw(%bounds, %options);
    ];
}

multi method draw(%bounds, %options) {
    # Override this if visual component
    $!svg.drawings;
}

multi method process(%options) {
    # Override this NOT a visual component
}

multi method relative($pct) {
    $!render_height * ($pct/100)
}

# vim: ft=perl6 sw=4 ts=4 expandtab
