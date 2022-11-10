use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::TypedBuffer;

our subset GskLinearGradientNodeAncestry is export of Mu
  where GskLinearGradientNode | GskRenderNode;

class GSK::Node::Gradient::Linear:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskLinearGradientNode $!gsk-lgn is implementor;

  submethod BUILD ( :$gsk-linear-gradient-node ) {
    self.setGskLinearGradientNode($gsk-linear-gradient-node)
      if $gsk-linear-gradient-node
  }

  method setGskLinearGradientNode (GskLinearGradientNodeAncestry $_) {
    my $to-parent;

    $!gsk-lgn = do {
      when GskLinearGradientNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskLinearGradientNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskLinearGradientNode
    is also<GskLinearGradientNode>
  { $!gsk-lgn }

  multi method new (
    GskLinearGradientNodeAncestry  $gsk-linear-gradient-node,
                                  :$ref                       = True
  ) {
    return unless $gsk-linear-gradient-node;

    my $o = self.bless( :$gsk-linear-gradient-node );
    $o.ref if $ref;
    $o;
  }

  multi method new (
    graphene_rect_t()  $bounds,
    graphene_point_t() $start,
    graphene_point_t() $end,
                       @colors
  ) {
    samewith(
      $bounds,
      $start,
      $end,
      GLib::Roles::TypedBuffer[GskColorStop].new(@colors).p,
      @colors.elems
    )
  }
  multi method new (
    graphene_rect_t()  $bounds,
    graphene_point_t() $start,
    graphene_point_t() $end,
    gpointer           $color_stops,
    Int()              $n_color_stops
  ) {
    my gsize $n = $n_color_stops;

    my $gsk-linear-gradient-node = gsk_linear_gradient_node_new(
      $bounds,
      $start,
      $end,
      $color_stops,
      $n
    );

    $gsk-linear-gradient-node ?? self.bless( :$gsk-linear-gradient-node )
                              !! Nil;
  }

  proto method get_color_stops (|)
    is also<get-color-stops>
  { * }

  multi method get_color_stops ( :$raw = False, :$buffer = False )
    is also<
      color_stops,
      color-stops
    >
  {
    samewith($, :all, :$raw, :$buffer)
  }
  multi method get_color_stops (
     $n_stops is rw,
    :$buffer         = False,
    :$all            = False
  ) {
    my gsize $n = 0;

    my $b = gsk_linear_gradient_node_get_color_stops($!gsk-lgn, $n);
    $n_stops = $n;
    my $br = bufferReturnTypedArray($b, GskColorStop, size => $n, :$buffer);
    return $br unless $all;
    ($all, $n_stops)
  }

  method get_end
    is also<
      get-end
      end
    >
  {
    gsk_linear_gradient_node_get_end($!gsk-lgn);
  }

  method get_n_color_stops
    is also<
      get-n-color-stops
      n_color_stops
      n-color-stops
    >
  {
    gsk_linear_gradient_node_get_n_color_stops($!gsk-lgn);
  }

  method get_start
    is also<
      get-start
      start
    >
  {
    gsk_linear_gradient_node_get_start($!gsk-lgn);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gsk_linear_gradient_node_get_type,
      $n,
      $t
    );
  }

}

INIT {
  my \O = GSK::Node::Gradient::Linear;
  %render-node-types<Gradient::Linear> = {
    object    => O,
    node-type => GSK_LINEAR_GRADIENT_NODE,
    type      => O.get_type
  }
}
