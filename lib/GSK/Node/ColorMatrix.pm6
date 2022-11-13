use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use Graphene::Matrix;
use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskColorMatrixNodeAncestry is export of Mu
  where GskColorMatrixNode | GskRenderNode;

class GSK::Node::ColorMatrix:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskColorMatrixNode $!gsk-cn is implementor;

  submethod BUILD ( :$gsk-colormatrix-node ) {
    self.setGskColorMatrixNode($gsk-colormatrix-node) if $gsk-colormatrix-node
  }

  method setGskColorMatrixNode (GskColorMatrixNodeAncestry $_) {
    my $to-parent;

    $!gsk-cn = do {
      when GskColorMatrixNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskColorMatrixNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskColorMatrixNode
    is also<GskColorMatrixNode>
  { $!gsk-cn }

  multi method new (
    GskColorMatrixNodeAncestry  $gsk-colormatrix-node,
                               :$ref                   = True
  ) {
    return unless $gsk-colormatrix-node;

    my $o = self.bless( :$gsk-colormatrix-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GskRenderNode()     $child,
    graphene_matrix_t() $color_matrix,
    graphene_vec4_t()   $color_offset
  ) {
    my $gsk-color-matrix = gsk_color_matrix_node_new(
      $child,
      $color_matrix,
      $color_offset
    );

    $gsk-color-matrix ?? self.bless( :$gsk-color-matrix ) !! Nil;
  }

  method get_child(
    :quick(:$fast)  = False,
    :$raw           = False,
    :slow(:$proper) = $fast.not
  )
    is also<
      get-child
      child
    >
  {
    returnProperNode(
      gsk_color_matrix_node_get_child($!gsk-cn),
      $raw,
      $proper
    );
  }

  method get_color_matrix ( :$raw = False )
    is also<
      get-color-matrix
      color_matrix
      color-matrix
    >
  {
    propReturnObject(
      gsk_color_matrix_node_get_color_matrix($!gsk-cn),
      $raw,
      |Graphene::Matrix.getTypePair
    );
  }

  method get_color_offset  ( :$raw = False )
    is also<
      get-color-offset
      color_offset
      color-offset
    >
  {
    propReturnObject(
      gsk_color_matrix_node_get_color_offset($!gsk-cn),
      $raw,
      |Graphene::Vec4.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_color_matrix_node_get_type, $n, $t );
  }

}

INIT {
  my \O = GSK::Node::ColorMatrix;
  %render-node-types<ColorMatrix> = {
    object    => O,
    node-type => GSK_CROSS_FADE_NODE,
    type      => O.get_type
  }
}
