use Tufte::Component::Base;

class Tufte::Component::DataMarkers is Tufte::Component::Base;

multi method draw($svg, %bounds, %options) {
    return unless %options<point_markers>;

    my $point_markers = %options<point_markers>.elems - 1;
    my $point_distance = %bounds<width> / $point_markers;
    for 0..$point_markers -> $idx {
        my $x_coord = $point_distance * $idx;
        $svg.drawings.push: :text[%options<point_markers>[$idx],
            x => $x_coord, y => %bounds<height>,
            font-size   => $.relative(90),
            font-family => %options<theme>.font_family,
            fill        => ~(%options<theme>.marker || 'white'),
            text-anchor => 'middle'] if %options<point_markers>[$idx];
    }
}

# vim: sw=4 ts=4 ft=perl6 expandtab
