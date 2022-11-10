use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::TypedBuffer;

our subset GskConicGradientNodeAncestry is export of Mu
  where GskConicGradientNode | GskRenderNode;

class GSK::Node::Gradient::Conic:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskConicGradientNode $!gsk-cgn is implementor;

  submethod BUILD ( :$gsk-conic-gradient-node ) {
    self.setGskConicGradientNode($gsk-conic-gradient-node) if $gsk-conic-gradient-node
  }

  method setGskConicGradientNode (GskConicGradientNodeAncestry $_) {
    my $to-parent;

    $!gsk-cgn = do {
      when GskConicGradientNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskConicGradientNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskConicGradientNode
    is also<GskConicGradientNode>
  { $!gsk-cgn }

  multi method new (
    GskConicGradientNodeAncestry  $gsk-conic-gradient-node,
                                 :$ref                      = True
  ) {
    return unless $gsk-conic-gradient-node;

    my $o = self.bless( :$gsk-conic-gradient-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $rotation,
                       @colors
  ) {
    samewith(
      $bounds,
      $center,
      $rotation,
      GLib::Roles::TypedBuffer.new(@colors),
      @colors.elems
    );
  }
  multi method new (
    graphene_rect_t()  $bounds,
    graphene_point_t() $center,
    Num()              $rotation,
    gpointer           $color_stops,
    Int()              $n_color_stops
  ) {
    my gfloat $r = $rotation;
    my gsize  $n = $n_color_stops;

    my $gsk-conic-gradient-node = gsk_conic_gradient_node_new(
      $bounds,
      $center,
      $r,
      $color_stops,
      $n
    );

    $gsk-conic-gradient-node ?? self.bless( :$gsk-conic-gradient-node )
                             !! Nil;
  }

  method get_angle
    is also<
      get-angle
      angle
    >
  {
    gsk_conic_gradient_node_get_angle($!gsk-cgn);
  }

  method get_center ( :$raw = False )
    is also<
      get-center
      center
    >
  {
    propReturnObject(
      gsk_conic_gradient_node_get_center($!gsk-cgn),
      $raw,
      |Graphene::Point.getTypePair
    );
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

    my $b = gsk_conic_gradient_node_get_color_stops($!gsk-cgn, $n);
    $n_stops = $n;
    my $br = bufferReturnTypedArray($b, GskColorStop, size => $n, :$buffer);
    return $br unless $all;
    ($all, $n_stops)
  }

  method get_n_color_stops
    is also<
      get-n-color-stops
      n_color_stops
      n-color-stops
    >
  {
    gsk_conic_gradient_node_get_n_color_stops($!gsk-cgn);
  }

  method get_rotation
    is also<
      get-rotation
      rotation
    >
  {
    gsk_conic_gradient_node_get_rotation($!gsk-cgn);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_conic_gradient_node_get_type, $n, $t );
  }

}

INIT {
  my \O = GSK::Node::Gradient::Conic;
  %render-node-types<Gradient::Conic> = {
    object    => O,
    node-type => GSK_CONIC_GRADIENT_NODE,
    type      => O.get_type
  }
}
