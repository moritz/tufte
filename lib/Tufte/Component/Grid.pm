use Tufte::Component::Base;

class Tufte::Component::Grid is Tufte::Component::Base;

has $.markers is rw;

multi method draw(%bounds, %options) {
	$!markers = %options<markers> // $!markers // 5;

	for 0..$!markers -> $idx {
	    my $marker = ((1 / ($!markers - 1)) * $idx) * %bounds<height>;
	    $!svg.drawings.push: :line[
	        :x1<0>, :y1($marker),
            :x2(%bounds<width>), :y2($marker),
            :style("stroke: %options<theme>.marker(); stroke-width: 2;")
	    ];
	}
    $!svg.drawings;
}

# vim: sw=4 ts=4 ft=perl6 expandtab
