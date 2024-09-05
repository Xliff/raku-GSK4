use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::Path:ver<4>;

use Graphene::Rect;

use GLib::Roles::Implementor;

class GSK::Path {
  also does GLib::Roles::Implementor;
  
  has GskPath $!gsk-p is implementor;

  submethod BUILD ( :$gsk-path ) {
    $!gsk-p = $gsk-path if $gsk-path;
  }

  method GSK::Raw::Structs::GskPath
  { $!gsk-p }

  multi method new (GskPath $gsk-path) {
    $gsk-path ?? self.bless( :$gsk-path ) !! Nil;
  }
  multi method new (Str() $p) {
    self.parse($p);
  }

  method parse (Str() $p, :$raw = False) {
    my $gsk-path = gsk_path_parse($p);

    return $gsk-path if $raw;
    $gsk-path ?? self.bless( :$gsk-path ) !! Nil;
  }

  method foreach (
    Int()    $flags,
             &func,
    gpointer $user_data = gpointer
  ) {
    my GskPathForeachFlags $f = $flags;

    gsk_path_foreach($!gsk-p, $f, &func, $user_data);
  }

  proto method get_bounds (|)
  { * }

  multi method get_bounds ( :$raw = False ) {
    my $r = Graphene::Rect.new;
    $r = samewith($r);
    return $r if $raw;
    Graphene::Rect.new($r);
  }
  multi method get_bounds (graphene_rect_t() $bounds) {
    gsk_path_get_bounds($!gsk-p, $bounds);
  }

  proto method get_closest_point (|)
  { * }

  multi method get_closest_point (
    graphene_point_t()  $point,
    gfloat()            $threshold = 0e0,
  ) {
    my $d;
    my $r = GSK::Path::Point.new;

    samewith($point, $threshold, $r, $d);
    ($r, $d);
  }
  multi method get_closest_point (
    graphene_point_t()  $point,
    gfloat()            $threshold,
    GskPathPoint()      $result,
                        $distance   is rw,
  ) {
    my gfloat ($t, $d) = ($threshold, 0e0);

    my $b = gsk_path_get_closest_point($!gsk-p, $point, $t, $result, $d);
    $distance = $d;
    ($result, $d);
  }

  proto method get_end_point (|)
  { * }

  multi method get_end_point ( :$raw = False ) {
    my $p = GSK::Path::Point.new;

    samewith($p);
    return $p
  }
  multi method get_end_point (GskPathPoint() $result) {
    gsk_path_get_end_point($!gsk-p, $result);
  }

  proto method get_start_point (|)
  { * }

  multi method get_start_point ( :$raw = False ) {
    my $p = GSK::Path::Point.new;

    samewith($p);
    return $p
  }
  multi method get_start_point (GskPathPoint() $result) {
    gsk_path_get_start_point($!gsk-p, $result);
  }

  proto method get_stroke_bounds (|)
  { * }

  multi method get_stroke_bounds (GskStroke() $stroke) {
    my $r = Graphene::Rect.new;

    samewith($stroke, $r);
    $r;
  }
  multi method get_stroke_bounds (
    GskStroke()       $stroke,
    graphene_rect_t() $bounds
  ) {
    gsk_path_get_stroke_bounds($!gsk-p, $stroke, $bounds);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_path_get_type, $n, $t );
  }

  method in_fill (
    graphene_point_t() $point,
    Int()              $fill_rule
  ) {
    my GskFillRule $fr = $fill_rule;

    gsk_path_in_fill($!gsk-p, $point, $fr);
  }

  method is_closed {
    so gsk_path_is_closed($!gsk-p);
  }

  method is_empty {
    so gsk_path_is_empty($!gsk-p);
  }

  multi method print {
    my $s = GLib::String.new;

    samewith($s);
    my $r = $s.str.clone;
    $s.free;
    $r;
  }
  multi method print (GString() $string) {
    gsk_path_print($!gsk-p, $string);
  }

  method ref {
    gsk_path_ref($!gsk-p);
    self;
  }

  method to_cairo (Cairo::cairo_t() $cr) {
    gsk_path_to_cairo($!gsk-p, $cr);
  }

  method to_string {
    gsk_path_to_string($!gsk-p);
  }

  method unref {
    gsk_path_unref($!gsk-p);
  }

}
