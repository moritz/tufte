use Tufte::Component::Base;

class Tufte::Component::Legend is Tufte::Component::Base {
    our $FONT_SIZE = 80;
    method draw($svg, %bounds, %options) {
        my $vertical = %options<vertical_legend>;
        my $legend_info = $.relevant_legend_info(%options<layers>);
        my ($line_height, $x, $y, $size) = 0 xx 4;
        if $vertical {
            # TODO: is the translation legend_info.length
            # into $legend_info.chars correct?
            $line_height = %bounds<height> / $legend_info.chars
                            min 0.08 * %bounds<height>;
        } else {
            $line_height = 0.9 * %bounds<height>;
        }
        my $text_height = $line_height * $FONT_SIZE / 100;
        my ($active_width, @points) = self.layout($legend_info, $vertical);
        my $offset = (%bounds<width> - active_width) / 2;
        for @points.kv -> $idx, $point {
            ($x, $y, $size) = $vertical ?? (0, $point, $line_height/2)
                                         !! ($offset + $point, 0, $.relative(50));
            $svg.drawings.push: 
                :rect[
                    :$x,
                    :$y,
                    :width($size),
                    :height($size),
                    :fill($legend_info[$idx]<color>),
                ],
                :text[
                    :x($x + $line_height),
                    :y($y + 0.75 * $text_height),
                    :font-size($text_height),
                    :font-family(%options<theme>.font_family),
                    :style("color: { %options<theme>.marker // 'white' }"),
                    :fill(%options<theme>.marker // 'white'),
                    ~$legend_info[$idx]<title>,
                ];
        }
    }

    method relevant_legend_info($layers, @categories = @.options<category> || @.options<categories>) {
        # TODO
        ...
    }

    method layout(@legend_info, $vertical?) {
        ...

    }

}

# vim: ft=perl6
