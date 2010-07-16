use Tufte::Component::Base;
use Tufte::Helper::Canvas;

class Tufte::Component::Viewport is Tufte::Component::Base does Tufte::Helper::Canvas;

multi method draw(%bounds, %options) {
    for @!components -> $component {
        $!svg.drawings.push: $component.render($.bounds_for([%bounds<width>, %bounds<height>], $component.position, $component.size), %options);
    }
    $!svg.drawings = :g[
        $.options_for,
        $!svg.drawings
    ];
}

multi method options_for() {
    my %options;
    %options<transform> ~= "$_($!options{$_})" for <skewX skewY>;
    %options;
}

# vim: sw=4 ts=4 ft=perl6 expandtab
