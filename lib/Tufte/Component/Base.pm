class Tufte::Component::Base;

has $.id;
has @.position is rw = (0, 0);
has @.size is rw = (100, 100);
has %.options is rw;
has $.visible is rw = True;
has $!render_height;

multi method render($svg, %bounds, %options) {
    return unless $.visible;
    %options = %options, %.options;

    return $.process($svg, %options) unless %bounds;

    $!render_height = %bounds<height>;

    $svg.drawings.push: g => [
        id => $.id,
        transform => "translate(%bounds.delete('x'), %bounds.delete('y'))"
    ];
    $.draw($svg, %bounds, %options);
}

multi method draw($svg, %bounds, %options) {
    # Override this if visual component
}

multi method process($svg, %options) {
    # Override this NOT a visual component
}

multi method relative($pct) {
    $!render_height * ($pct/100)
}

# vim: ft=perl6 sw=4 ts=4 expandtab
