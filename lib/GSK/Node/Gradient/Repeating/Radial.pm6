use v6.c;

use Method::Also;
use NativeCall;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;
use GSK::Node::Gradient::Radial:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::TypedBuffer;

our subset GskRepeatingRadialGradientNodeAncestry is export of Mu
  where GskRepeatingRadialGradientNode | GskRenderNode;

class GSK::Node::Gradient::Repeating::Radial:ver<4>
  is GSK::Node::Gradient::Radial:ver<4>
{
  also does GLib::Roles::Implementor;

  has GskRepeatingRadialGradientNode $!gsk-rrgn is implementor;

  submethod BUILD ( :$gsk-repeating-radial-gradient-node ) {
    self.setGskRepeatingRadialGradientNode(
      $gsk-repeating-radial-gradient-node
    ) if $gsk-repeating-radial-gradient-node
  }

  method setGskRepeatingRadialGradientNode (
    GskRepeatingRadialGradientNodeAncestry $_
  ) {
    my $to-parent;

    $!gsk-rrgn = do {
      when GskRepeatingRadialGradientNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskRepeatingRadialGradientNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskRepeatingRadialGradientNode
    is also<GskRepeatingRadialGradientNode>
  { $!gsk-rrgn }

  multi method new (
    GskRepeatingRadialGradientNodeAncestry  $gsk-rradial-gradient-node,
                                           :$ref                        = True
  ) {
    return unless $gsk-rradial-gradient-node;

    my $o = self.bless( :$gsk-rradial-gradient-node );
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
    gpointer           $color_stops,
    Int()              $n_color_stops
  ) {
    my gfloat ($h, $v, $s, $e) = ($hradius, $vradius, $start, $end);
    my gsize   $n              =  $n_color_stops;

    my $gsk-rradial-gradient-node = gsk_repeating_radial_gradient_node_new(
      $bounds,
      $center,
      $h,
      $v,
      $s,
      $e,
      $color_stops,
      $n
    );

    $gsk-rradial-gradient-node ?? self.bless( :$gsk-rradial-gradient-node )
                               !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gsk_repeating_radial_gradient_node_get_type,
      $n,
      $t
    );
  }

}
