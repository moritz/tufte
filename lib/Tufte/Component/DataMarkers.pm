use Tufte::Component::Base;

class Tufte::Component::DataMarkers is Tufte::Component::Base;

multi method draw(%bounds, %options) {
    return unless %options<point_markers>;

    my $point_markers  = %options<point_markers>.end;
    my $point_distance = %bounds<width> / $point_markers;
    for 0..$point_markers -> $idx {
        my $x_coord = $point_distance * $idx;
        $!svg.drawings.push: :text[
            :x($x_coord), :y(%bounds<height>),
            font-size   => $.relative(90),
            font-family => %options<theme>.font_family,
            fill        => ~(%options<theme>.marker || 'white'),
            text-anchor => 'middle',
            ~%options<point_markers>[$idx],
        ] if %options<point_markers>[$idx];
    }
    $!svg.drawings;
}

# vim: sw=4 ts=4 ft=perl6 expandtab
