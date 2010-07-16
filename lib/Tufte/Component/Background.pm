use Tufte::Component::Base;

class Tufte::Component::Background is Tufte::Component::Base {
    # TODO: make %options a slurpy named?
    multi method draw(%bounds, %options) {
        my $fill = '#EEEEEE';
        given %options<theme>.background {
            when Str {
                $fill = $_;
            }
            when Positional {
                $fill = 'url(#BackgroundGradient)';
		$!svg.defs = :defs[
		    :linearGradient[
			:id<BackgroundGradient>,
			:x1<0%>, :y1<0%>,
			:x2<0%>, :y2<100%>,
			:stop[
			    :offset<5%>,
			    stop-color => %options<theme>.background[0],
			],
			:stop[
			    :offset<95%>,
			    stop-color => %options<theme>.background[1],
			],
		    ]
                ];
            }

        }

	# Render background (maybe)
	$!svg.drawings = :rect[
	    :width(%bounds<width>), :height(%bounds<height>),
	    :x<0>, :y<0>, :$fill
	] if $fill;

	$!svg.defs, $!svg.drawings;
    }
}

# vim: ft=perl6
