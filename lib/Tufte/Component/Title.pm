use Tufte::Component::Base;

class Tufte::Component::Title is Tufte::Component::Base {
    multi method draw(%bounds, %options) {
        if %options.exists<title> {
            $!svg.drawings.push: :text[
                :class<title>,
                :x(%bounds<width> / 2),
                :y(%bounds<height>),
                # TODO: promote these to :style(something)
                :font-size($.relative(100)),
                :font-family(%options<theme>.font-family),
                :fill(%options<theme>.marker),
                :stroke("none; stroke-width: 0"),
                :text-anchor(%options<text_anchor> // 'middle'),
                ~%options<title>,
            ],
        }
	$!svg.drawings;
    }
}

# vim: ft=perl6
