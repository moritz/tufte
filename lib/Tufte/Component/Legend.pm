use Tufte::Component::Base;

class Tufte::Component::Legend is Tufte::Component::Base {
    has $!line_height;
    our $FONT_SIZE = 80;

    method draw($svg, %bounds, %options) {
        my $vertical = %options<vertical_legend>;
        my @legend_info = $.relevant_legend_info(%options<layers>);
        my ($x, $y, $size) = 0 xx 3;
	$!line_height = $vertical ?? (%bounds<height> / @legend_info.elems) min (0.08 * %bounds<height>) !!
            0.9 * %bounds<height>;
        my $text_height = $!line_height * $FONT_SIZE / 100;
        my ($active_width, @points) = self.layout(@legend_info, $vertical);
        my $offset = (%bounds<width> - $active_width) / 2;
        for @points.kv -> $idx, $point {
            ($x, $y, $size) = $vertical ?? (0, $point, $!line_height/2)
                                         !! ($offset + $point, 0, $.relative(50));
            $svg.drawings.push: 
                :rect[
                    :$x,
                    :$y,
                    :width($size),
                    :height($size),
                    :fill(@legend_info[$idx]<color>),
                ],
                :text[
                    :x($x + $!line_height),
                    :y($y + 0.75 * $text_height),
                    :font-size($text_height),
                    :font-family(%options<theme>.font_family),
                    :style("color: { %options<theme>.marker // 'white' }"),
                    :fill(%options<theme>.marker // 'white'),
                    ~@legend_info[$idx]<title>,
                ];
        }
    }

    method relevant_legend_info(@layers, @categories = @.options<category> // @.options<categories>) {
	return @layers».legend_data unless @categories;

	@layers.grep({ @categories ~~ .options<category> ||
	    .options<categories> && any(@categories) ~~ any(.options<categories>) })».legend_data;

    }

    method layout(@legend_info, $vertical?) {
	if $vertical {
	    my $longest = 0;
	    for @legend_info -> $elem {
		$longest = $longest max $.relative(50) * $elem<title>.chars;
	    }
	    my @y_positions;
	    for 0..@legend_info.end -> $y {
		@y_positions.push: $y * $!line_height;
	    }
	    return ($longest, [@y_positions]);
	}

	my @enum = 0, [];
	for @legend_info -> $elem {
	    @enum[1].push: @enum[0];                         # Add location to points
	    @enum[0] += $.relative(50);                      # Add room for color box
	    @enum[0] += $.relative(50) * $elem<title>.chars; # Add room for text
	    @enum[0] += $.relative(50) * 2;                  # Add spacer between elements
	}
	@enum;
    }

}

# vim: ft=perl6
