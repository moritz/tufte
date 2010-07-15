use Tufte::Component::Base;

class Tufte::Component::Label is Tufte::Component::Base {
    multi method draw($svg, %bounds, %options) {
	$svg.drawings.push: :text[%options<text>,
	    :class<text>,
	    x => %bounds<width>/2, y => %bounds<height>,
	    font-size   => $.relative(100),
	    font-family => %options<theme>.font_family,
	    fill        => %options<theme>.marker,
	    :stroke<none>, :stroke-width<0>,
	    text-anchor => (%options<text_anchor> // 'middle')
	];
    }
}

# vim: sw=4 ts=4 ft=perl6 expandtab
