use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use Graphene::Point;
use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::TypedBuffer;

our subset GskRadialGradientNodeAncestry is export of Mu
  where GskRadialGradientNode | GskRenderNode;

class GSK::Node::RadialGradient:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskRadialGradientNode $!gsk-rgn is implementor;

  submethod BUILD ( :$gsk-radial-gradient-node ) {
    self.setGskRadialGradientNode($gsk-radial-gradient-node) if $gsk-radial-gradient-node
  }

  method setGskRadialGradientNode (GskRadialGradientNodeAncestry $_) {
    my $to-parent;

    $!gsk-rgn = do {
      when GskRadialGradientNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskRadialGradientNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskRadialGradientNode
    is also<GskRadialGradientNode>
  { $!gsk-rgn }

  multi method new (
    GskRadialGradientNodeAncestry  $gsk-radial-gradient-node,
                                  :$ref                       = True
  ) {
    return unless $gsk-radial-gradient-node;

    my $o = self.bless( :$gsk-radial-gradient-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $hradius,
    Num()              $vradius,
    Num()              $start,
    Num()              $end,
    gpointer           $color_stops,
    Int()              $n_color_stops
  ) {
    my gfloat ($h, $v, $s, $e) = ($hradius, $vradius, $start, $end);
    my gsize   $n              = $n_color_stops;

    my $gsk-radial-gradient-node = gsk_radial_gradient_node_new(
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

  method get_center ( :$raw = False )
    is also<
      get-center
      center
    >
  {
    propReturnObject(
      gsk_radial_gradient_node_get_center($!gsk-rgn),
      $raw,
      |Graphene::Point.getTypePair
    );
  }

  proto method get_color_stops (|)
  { * }

  multi method get_color_stops ( :$raw = False, :$buffer = False ) {
    samewith($, :$raw, :$buffer)
  }
  multi method get_color_stops (
     $n_stops is rw,
    :$raw            = False,
    :$buffer         = False
  )
    is also<
      get-color-stops
      color_stops
      color-stops
    >
  {
    my gsize $n = $n_stops;

    my $cb = gsk_radial_gradient_node_get_color_stops($!gsk-rgn, $n);
    ($n_stops = $n);
    $cb = bufferReturnTypedArray($cb, $raw, $buffer, GskColorStop);
    ($cb, $n_stops);
  }

  method get_end
    is also<
      get-end
      end
    >
  {
    gsk_radial_gradient_node_get_end($!gsk-rgn);
  }

  method get_hradius
    is also<
      get-hradius
      hradius
    >
  {
    gsk_radial_gradient_node_get_hradius($!gsk-rgn);
  }

  method get_n_color_stops
    is also<
      get-n-color-stops
      n_color_stops
      n-color-stops
    >
  {
    gsk_radial_gradient_node_get_n_color_stops($!gsk-rgn);
  }

  method get_start
    is also<
      get-start
      start
    >
  {
    gsk_radial_gradient_node_get_start($!gsk-rgn);
  }

  method get_type is also<get-type> {
    my ($n, $t);

    unstable_get_type(
      self.^name,
      &gsk_radial_gradient_node_get_type,
      $n,
      $t
    );
  }

  method get_vradius
    is also<
      get-vradius
      vradius
    >
  {
    gsk_radial_gradient_node_get_vradius($!gsk-rgn);
  }

}
