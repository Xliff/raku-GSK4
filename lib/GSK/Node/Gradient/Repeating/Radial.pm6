use v6.c;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

class GSK::Node::Gradient::Repeating::Radial is GSK::RenderNode {
  also does GLib::Roles::Implementor;

  has GskRepeatingRadialGradientNode $!gsk-cn is implementor;

  multi method new (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $hradius,
    Num()              $vradius,
    Num()              $start,
    Num()              $end,
                       @color_stops
  ) {
    samewith(
      $bounds,
      $center,
      $hradius,
      $vradius,
      $start,
      $end,
      GLib::Roles::TypedBuffer[GskColorStop].new(@color_stops).p,
      @color_stops.elems
    );
  }
  multi method new (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $hradius,
    Num()              $vradius,
    Num()              $start,
    Num()              $end,
    Blob               $color_stops,
    Int()              $n_color_stops
  ) {
    samewith(
      $bounds,
      $center,
      $hradius,
      $vradius,
      $start,
      $end,
      cast( Pointer, CArray[uint8].new($color_stops) ),
      $n_color_stops
    );
  }
  multi method new (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $hradius,
    Num()              $vradius,
    Num()              $start,
    Num()              $end,
    Pointer            $color_stops,
    Int()              $n_color_stops
  ) {
    my gfloat ($h, $v, $s, $e) = ($hradius, $vradius, $start, $end);
    my gsize   $n              =  $n_color_stops;

    gsk_repeating_radial_gradient_node_new(
      $bounds,
      $center,
      $h,
      $v,
      $s,
      $e,
      $color_stops,
      $n
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gsk_repeating_radial_gradient_node_get_type
      $n,
      $t
    );
  }

}
