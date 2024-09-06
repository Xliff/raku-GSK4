use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::Path::Point:ver<4>;

use GLib::Roles::Implementor;

class GSK::Path::Point {
  has GskPathPoint $!gsk-pp is implementor;

  submethod BUILD ( :$gsk-path-point ) {
    $!gsk-pp = $gsk-path-point if $gsk-path-point;
  }

  method GSK::Raw::Structs::GskPathPoint
  { $!gsk-pp }

  multi method new (GskPathPoint $gsk-path-point) {
    $gsk-path-point ?? self.bless( :$gsk-path-point ) !! Nil;
  }

  method compare (GskPathPoint() $point2) {
    gsk_path_point_compare($!gsk-pp, $point2);
  }

  method copy ( :$raw = False ) {
    propReturnObject(
       gsk_path_point_copy($!gsk-pp),
       $raw,
       |self.getTypePair,
      :!ref
    )
  }

  method equal (GskPathPoint() $point2) {
    so gsk_path_point_equal($!gsk-pp, $point2);
  }

  method free {
    gsk_path_point_free($!gsk-pp);
  }

  method get_curvature (
    GskPath()          $path,
    Int()              $direction,
    graphene_point_t() $center
  ) {
    my GskPathDirection $d = $direction;
    gsk_path_point_get_curvature($!gsk-pp, $path, $direction, $center);
  }

  method get_distance (GskPathMeasure() $measure) {
    gsk_path_point_get_distance($!gsk-pp, $measure);
  }

  proto method get_position (|)
  { * }

  multi method get_position ($path) {
    my $p = Graphene::Point.new;

    samewith($path, $p);
    $p;
  }

  multi method get_position (
    GskPath()          $path,
    graphene_point_t() $position
  ) {
    gsk_path_point_get_position($!gsk-pp, $path, $position);
  }

  method get_rotation (GskPath() $path, Int() $direction) {
    my GskPathDirection $d = $direction;

    gsk_path_point_get_rotation($!gsk-pp, $path, $d);
  }

  proto method get_tangent (|)
  { * }

  multi method get_tangent (GskPath() $path, Int() $direction) {
    my GskPathDirection $d = $direction;

    my $t = Graphene::Vector2.new;

    samewith($path, $d, $t);
    $t;
  }
  multi method get_tangent (
    GskPath()         $path,
    Int()             $direction,
    graphene_vec2_t() $tangent
  ) {
    my GskPathDirection $d = $direction;

    gsk_path_point_get_tangent($!gsk-pp, $path, $d, $tangent);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_path_point_get_type, $n, $t );
  }

}
