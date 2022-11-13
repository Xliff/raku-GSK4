use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;
use GSK::Node::Gradient::Linear:ver<4>;

our subset GskRepeatingLinearGradientNodeAncestry is export of Mu
  where GskRepeatingLinearGradientNode | GskLinearGradientNodeAncestry;

class GSK::Node::Gradient::Repeating::Linear:ver<4>
  is GSK::Node::Gradient::Linear:ver<4>
{
  also does GLib::Roles::Implementor;

  has GskRepeatingLinearGradientNode $!gsk-rlgn is implementor;

  submethod BUILD ( :$gsk-rlinear-gradient-node ) {
    self.setGskRepeatingLinearGradientNode($gsk-rlinear-gradient-node)
      if $gsk-rlinear-gradient-node
  }

  method setGskRepeatingLinearGradientNode (
    GskRepeatingLinearGradientNodeAncestry $_
  ) {
    my $to-parent;

    $!gsk-rlgn = do {
      when GskRepeatingLinearGradientNode {
        $to-parent = cast(GskLinearGradientNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskRepeatingLinearGradientNode, $_);
      }
    }
    self.setRepeatingLinearGradient($to-parent);
  }

  method GSK::Raw::Definitions::GskRepeatingLinearGradientNode
    is also<GskRepeatingLinearGradientNode>
  { $!gsk-rlgn }

  multi method new (
    GskRepeatingLinearGradientNodeAncestry  $gsk-rlinear-gradient-node,
                                           :$ref                        = True
  ) {
    return unless $gsk-rlinear-gradient-node;

    my $o = self.bless( :$gsk-rlinear-gradient-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    graphene_rect_t()  $bounds,
    graphene_point_t() $start,
    graphene_point_t() $end,
                       @color-stops
  ) {
    samewith(
      $bounds,
      $start,
      $end,
      GLib::Roles::TypedBuffer[GskColorStop].new(@color-stops).p,
      @color-stops.elems
    );
  }
  multi method new (
    graphene_rect_t()  $bounds,
    graphene_point_t() $start,
    graphene_point_t() $end,
    gpointer           $color_stops,
    Int()              $n_color_stops
  ) {
    my gsize $n = $n_color_stops;

    my $gsk-rlinear-gradient = gsk_repeating_linear_gradient_node_new(
      $bounds,
      $start,
      $end,
      $color_stops,
      $n
    );

    $gsk-rlinear-gradient
      ?? self.bless( :$gsk-rlinear-gradient )
      !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gsk_repeating_linear_gradient_node_get_type,
      $n,
      $t
    );
  }

}

INIT {
  my \O = GSK::Node::Gradient::Repeating::Linear;
  %render-node-types<Gradient::Repeating::Linear> = {
    object    => O,
    node-type => GSK_REPEATING_LINEAR_GRADIENT_NODE,
    type      => O.get_type
  }
}
