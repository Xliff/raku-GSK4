use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::Path::Builder:ver<4>;

use GLib::Roles::Implementor;

class GSK::Path::Builder {
  also does GLib::Roles::Implementor;

  has GskPathBuilder $!gsk-pb is implementor;

  submethod BUILD ( :$gsk-path-builder ) {
    $!gsk-pb = $gsk-path-builder if $gsk-path-builder;
  }

  method GSK::Raw::Structs::GskPathBuilder
  { $!gsk-pb }

  multi method new (GskPathBuilder $gsk-path-builder, :$ref = True) {
    return Nil unless $gsk-path-builder;

    my $o = $gsk-path-builder ?? self.bless( :$gsk-path-builder ) !! Nil;
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gsk-path-builder = gsk_path_builder_new();

    $gsk-path-builder ?? self.bless( :$gsk-path-builder ) !! Nil;
  }

  method add_cairo_path (Cairo::cairo_path_t() $path) {
    gsk_path_builder_add_cairo_path($!gsk-pb, $path);
  }

  method add_circle (graphene_point_t() $center, Num() $radius) {
    my gfloat $r = $radius;

    gsk_path_builder_add_circle($!gsk-pb, $center, $r);
  }

  method add_layout (PangoLayout() $layout) {
    gsk_path_builder_add_layout($!gsk-pb, $layout);
  }

  method add_path (GskPath() $path) {
    gsk_path_builder_add_path($!gsk-pb, $path);
  }

  method add_rect (graphene_rect_t() $rect) {
    gsk_path_builder_add_rect($!gsk-pb, $rect);
  }

  method add_reverse_path (GskPath() $path) {
    gsk_path_builder_add_reverse_path($!gsk-pb, $path);
  }

  method add_rounded_rect (GskRoundedRect() $rect) {
    gsk_path_builder_add_rounded_rect($!gsk-pb, $rect);
  }

  method add_segment (
    GskPath()      $path,
    GskPathPoint() $start,
    GskPathPoint() $end
  ) {
    gsk_path_builder_add_segment($!gsk-pb, $path, $start, $end);
  }

  method arc_to (
    Num()  $x1,
    Num()  $y1,
    Num()  $x2,
    Num()  $y2,
          :r(:rel(:$relative)) = False
  ) {
    my gfloat ($xx1, $yy1, $xx2, $yy2) = ($x1, $y1, $x2, $y2);

    $relative
      ?? gsk_path_builder_rel_arc_to($!gsk-pb, $xx1, $yy1, $xx2, $yy2)
      !! gsk_path_builder_arc_to($!gsk-pb, $xx1, $yy1, $xx2, $yy2)
  }

  method close {
    gsk_path_builder_close($!gsk-pb);
  }

  method conic_to (
    Num()  $x1,
    Num()  $y1,
    Num()  $x2,
    Num()  $y2,
    Num()  $weight,
          :r(:rel(:$relative)) = False
  ) {
    my gfloat ($xx1, $yy1, $xx2, $yy2, $w) = ($x1, $y1, $x2, $y2, $weight);

    $relative
      ?? gsk_path_builder_rel_conic_to($!gsk-pb, $xx1, $yy1, $xx2, $yy2, $w)
      !! gsk_path_builder_conic_to($!gsk-pb, $xx1, $yy1, $xx2, $yy2, $w);
  }

  method cubic_to (
    Num()  $x1,
    Num()  $y1,
    Num()  $x2,
    Num()  $y2,
    Num()  $x3,
    Num()  $y3,
          :r(:rel(:$relative)) = False
  ) {
    my gfloat ($xx1, $yy1, $xx2, $yy2, $xx3, $yy3)  =
      ($x1, $y1, $x2, $y2, $x3, $y3);

    $relative
      ?? gsk_path_builder_rel_cubic_to(
           $!gsk-pb,
           $xx1,
           $yy1,
           $xx2,
           $yy2,
           $xx3,
           $yy3
         )
      !! gsk_path_builder_cubic_to(
           $!gsk-pb,
           $xx1,
           $yy1,
           $xx2,
           $yy2,
           $xx3,
           $yy3
         );
  }

  method free_to_path {
    gsk_path_builder_free_to_path($!gsk-pb);
  }

  method get_current_point ( :$raw = False ) {
    propReturnObject(
      gsk_path_builder_get_current_point($!gsk-pb),
      $raw,
      |Graphene::Point.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_path_builder_get_type, $n, $t );
  }

  method html_arc_to (
    Num()  $x1,
    Num()  $y1,
    Num()  $x2,
    Num()  $y2,
    Num()  $radius,
          :r(:rel(:$relative)) = False
  ) {
    my gfloat ($xx1, $yy1, $xx2, $yy2, $r) = ($x1, $y1, $x2, $y2, $radius);

    $relative
      ?? gsk_path_builder_html_arc_to($!gsk-pb, $xx1, $yy1, $xx2, $yy2, $r)
      !! gsk_path_builder_rel_html_arc_to($!gsk-pb, $xx1, $yy1, $xx2, $yy2, $r)
  }

  method line_to (Num() $x1, Num() $y1, :r(:rel(:$relative)) = False) {
    my gfloat ($xx1, $yy1)  = ($x1, $y1);

    $relative
      ?? gsk_path_builder_rel_line_to($!gsk-pb, $xx1, $yy1)
      !! gsk_path_builder_line_to($!gsk-pb, $xx1, $yy1);
  }

  method move_to (Num() $x1, Num() $y1, :r(:rel(:$relative)) = False) {
    my gfloat ($xx1, $yy1)  = ($x1, $y1);

    $relative
      ?? gsk_path_builder_rel_move_to($!gsk-pb, $xx1, $yy1)
      !! gsk_path_builder_move_to($!gsk-pb, $xx1, $yy1);
  }

  method quad_to (
    Num()  $x1,
    Num()  $y1,
    Num()  $x2,
    Num()  $y2,
          :r(:rel(:$relative)) = False
  ) {
    my gfloat ($xx1, $yy1, $xx2, $yy2) = ($x1, $y1, $x2, $y2);

    $relative
      ?? gsk_path_builder_rel_quad_to($!gsk-pb, $xx1, $yy1, $xx2, $yy2)
      !! gsk_path_builder_quad_to($!gsk-pb, $xx1, $yy1, $xx2, $yy2)
  }

  method ref {
    gsk_path_builder_ref($!gsk-pb);
    self;
  }

  method rel_arc_to ($x1, $y1, $x2, $y2) {
    $.arc_to($x1, $y1, $x2, $y2, :r);
  }

  method rel_conic_to ($x1, $y1, $x2, $y2, $weight) {
    $.conic_to($x1, $y1, $x2, $y2, $weight, :r);
  }

  method rel_cubic_to ($x1, $y1, $x2, $y2, $x3, $y3) {
    $.cubic_to($!gsk-pb, $x1, $y1, $x2, $y2, $x3, $y3, :r);
  }

  method rel_html_arc_to ($x1, $y1, $x2, $y2, $radius) {
    $.html_arc_to($x1, $y1, $x2, $y2, $radius, :r);
  }

  method rel_line_to ($x, $y) {
    $.line_to($x, $y, :r);
  }

  method rel_move_to ($x, $y) {
    $.move_to($x, $y, :r);
  }

  method rel_quad_to ($x1, $y1, $x2, $y2) {
    $.quad_to($x1, $y1, $x2, $y2, :r);
  }

  method rel_svg_arc_to (
    $rx,
    $ry,
    $x_axis_rotation,
    $large_arc,
    $positive_sweep,
    $x,
    $y
  ) {
    $.svg_arc_to(
      $rx,
      $ry,
      $x_axis_rotation,
      $large_arc,
      $positive_sweep,
      $x,
      $y,
      :r
    );
  }

  method svg_arc_to (
    Num()  $rx,
    Num()  $ry,
    Num()  $x_axis_rotation,
    Int()  $large_arc,
    Int()  $positive_sweep,
    Num()  $x,
    Num()  $y,
          :r(:rel(:$relative)) = False
  ) {
    my gfloat ($rrx, $rry, $xar, $xx, $yy) =
      ($rx, $ry, $x_axis_rotation, $x, $y);

    my gboolean ($l, $p) = ($large_arc, $positive_sweep).map( *.so.Int );

    $relative
      ?? gsk_path_builder_rel_svg_arc_to(
           $!gsk-pb,
           $rrx,
           $rry,
           $xar,
           $l,
           $p,
           $xx,
           $yy
         )
      !! gsk_path_builder_svg_arc_to(
           $!gsk-pb,
           $rrx,
           $rry,
           $xar,
           $l,
           $p,
           $xx,
           $yy
         )
  }

  method to_path ( :$raw = False ) {
    propReturnObject(
      gsk_path_builder_to_path($!gsk-pb),
      $raw,
      |GSK::Path.getTypePair
    );
  }

  method unref {
    gsk_path_builder_unref($!gsk-pb);
  }

}
