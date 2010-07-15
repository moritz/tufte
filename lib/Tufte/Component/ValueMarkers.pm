use Tufte::Component::Base;

class Tufte::Component::ValueMarkers is Tufte::Component::Base;

has $.markers is rw;

multi method draw(%bounds, %options) {
    my $markers = %options<markers> // $!markers // 5;
    my @all_values;

    for 0..$markers -> $idx {
	@all_values.push: (%options<max_value> - %options<min_value>) * ((1 / ($markers - 1)) * $idx) + %options<min_value>;
    }

    for 0..$markers -> $idx {
	my $marker_unit = (1 / ($markers - 1)) * $idx;
	my $marker = $marker_unit * %bounds<height>;
	my $marker_value = (%options<max_value> - %options<min_value>) * $marker_unit + %options<min_value>;
	if %options<value_formatter> {
	    %options<all_values> = @all_values;
	    $marker_value    = %options<value_formatter>.route_format($marker_value, $idx, %options);
	}

	$!svg.drawings = :text[
	    :x(%bounds<width>), :y(%bounds<height> - $marker),
	    :font-size($.relative(8)),
	    :font-family(%options<theme>.font_family),
	    :fill(~(%options.delete<marker_color_override> || %options<theme>.marker || 'white')),
	    :text-anchor<end>,
	    ~$marker_value
	];
    }
}

# vim: sw=4 ts=4 ft=perl6 expandtab
