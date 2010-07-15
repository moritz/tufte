use Tufte::Component::Base;

class Tufte::Component::Label is Tufte::Component::Base;

multi method draw(%bounds, %options) {
	$!svg.drawings = :text[
	    :class<text>,
	    x => %bounds<width>/2, y => %bounds<height>,
	    font-size   => $.relative(100),
	    font-family => %options<theme>.font_family,
	    fill        => %options<theme>.marker,
	    :stroke<none>, :stroke-width<0>,
	    text-anchor => (%options<text_anchor> // 'middle')
        ~%options<text>
	];
}

# vim: sw=4 ts=4 ft=perl6 expandtab
