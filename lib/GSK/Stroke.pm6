use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use GSK::Raw::Types:ver<4>;
use GSK::Raw::Stroke:ver<4>;

use GLib::Roles::Implementor;

class GSK::Stroke {
  also does GLib::Roles::Implementor;

  has GskStroke $!gsk-s is implementor;

  submethod BUILD ( :$gsk-stroke ) {
    $!gsk-s = $gsk-stroke if $gsk-stroke
  }

  method GSK::Raw::Definitions::GskStroke
  { $!gsk-s }

  multi method new (GskStroke $gsk-stroke, :$ref = True) {
    return unless $gsk-stroke;

    my $o = self.bless( :$gsk-stroke );
    $o.ref if $ref;
    $o;
  }
  multi method new (Num() $width = 1e0) {
    my num32 $w = $width;

    my $gsk-stroke = gsk_stroke_new($w);

    $gsk-stroke ?? self.bless( :$gsk-stroke ) !! Nil;
  }

  method dash is rw is g-pseudo-property {
    Proxy.new:
      FETCH => -> $     { self.get_dash    },
      STORE => -> $, \v { self.set_dash(v) }
  }

  method dash_offset is rw is g-pseudo-property {
    Proxy.new:
      FETCH => -> $     { self.get_dash_offset    },
      STORE => -> $, \v { self.set_dash_offset(v) }
  }

  method line_cap is rw is g-pseudo-property {
    Proxy.new:
      FETCH => -> $     { self.get_line_cap    },
      STORE => -> $, \v { self.set_line_cap(v) }
  }

  method line_join is rw is g-pseudo-property {
    Proxy.new:
      FETCH => -> $     { self.get_line_join    },
      STORE => -> $, \v { self.set_line_join(v) }
  }

  method line_width is rw is g-pseudo-property {
    Proxy.new:
      FETCH => -> $     { self.get_line_width    },
      STORE => -> $, \v { self.set_line_width(v) }
  }

  method miter_limit is rw is g-pseudo-property {
    Proxy.new:
      FETCH => -> $     { self.get_miter_limit    },
      STORE => -> $, \v { self.set_miter_limit(v) }
  }

  method copy ( :$raw = False ) {
    propReturnObject(
       gsk_stroke_copy($!gsk-s),
       $raw,
       |self.getTypePair,
      :!ref
    );
  }

  method equal (GskStroke() $stroke2) {
    gsk_stroke_equal($!gsk-s, $stroke2);
  }

  method free {
    gsk_stroke_free($!gsk-s);
  }

  method get_dash (
    GskStroke $self,
    gsize     $n_dash
  ) {
    gsk_stroke_get_dash($!gsk-s, $n_dash);
  }

  method get_dash_offset {
    gsk_stroke_get_dash_offset($!gsk-s);
  }

  method get_line_cap  ( :$enum = True ) {
    my $l = gsk_stroke_get_line_cap($!gsk-s);
    return $l unless $enum;
    GskLineCapEnum($l);
  }

  method get_line_join ( :$enum = True ) {
    my $l = gsk_stroke_get_line_join($!gsk-s);
    return $l unless $enum;
    GskLineJoinEnum($l);
  }

  method get_line_width {
    gsk_stroke_get_line_width($!gsk-s);
  }

  method get_miter_limit {
    gsk_stroke_get_miter_limit($!gsk-s);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_stroke_get_type, $n, $t );
  }

  proto method set_dash (|)
  { * }

  multi method set_dash (@dashes) {
    samewith( ArrayToCArray(gfloat, @dashes), @dashes.elems )
  }
  multi method set_dash (CArray[gfloat] $dash is rw, Int() $n_dash) {
    my gsize $n = $n_dash;

    gsk_stroke_set_dash($!gsk-s, $dash, $n);
  }

  method set_dash_offset (Num() $offset) {
    my gfloat $o = $offset;

    gsk_stroke_set_dash_offset($!gsk-s, $o);
  }

  method set_line_cap (Int() $line_cap) {
    my GskLineCap $l = $line_cap;

    gsk_stroke_set_line_cap($!gsk-s, $l);
  }

  method set_line_join (Int() $line_join) {
    my GskLineJoin $l = $line_join;

    gsk_stroke_set_line_join($!gsk-s, $l);
  }

  method set_line_width (Num() $line_width) {
    my gfloat $l = $line_width;

    gsk_stroke_set_line_width($!gsk-s, $l);
  }

  method set_miter_limit (Num() $limit) {
    my gfloat $l = $limit;

    gsk_stroke_set_miter_limit($!gsk-s, $l);
  }

  method to_cairo (Cairo::cairo_t() $cr) {
    gsk_stroke_to_cairo($!gsk-s, $cr);
  }

}
