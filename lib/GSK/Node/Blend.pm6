use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskBlendNodeAncestry is export of Mu
  where GskBlendNode | GskRenderNode;

class GSK::Node::Blend:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskBlendNode $!gsk-bn is implementor;

  submethod BUILD ( :$gsk-blend-node ) {
    self.setGskBlendNode($gsk-blend-node) if $gsk-blend-node
  }

  method setGskBlendNode (GskBlendNodeAncestry $_) {
    my $to-parent;

    $!gsk-bn = do {
      when GskBlendNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskBlendNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskBlendNode
    is also<GskBlendNode>
  { $!gsk-bn }

  multi method new (GskBlendNodeAncestry $gsk-blend-node, :$ref = True) {
    return unless $gsk-blend-node;

    my $o = self.bless( :$gsk-blend-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GskRenderNode() $bottom,
    GskRenderNode() $top,
    GskBlendMode  $blend_mode
  ) {
    my GskBlendMode $b = $blend_mode;

    my $gsk-blend-node = gsk_blend_node_new($bottom, $top, $b);

    $gsk-blend-node ?? self.bless( :$gsk-blend-node ) !! Nil;
  }


  method get_blend_mode ( :$enum = True )
    is also<
      get-blend-mode
      blend_mode
      blend-mode
    >
  {
    my $m = gsk_blend_node_get_blend_mode($!gsk-bn);
    return $m unless $enum;
    GskBlendModeEnum($m);
  }

  method get_bottom_child ( :$raw = False )
    is also<
      get-bottom-child
      bottom_child
      bottom-child
    >
  {
    propReturnObject(
      gsk_blend_node_get_bottom_child($!gsk-bn),
      $raw,
      |GSK::RenderNode.getTypePair
    );
  }

  method get_top_child ( :$raw = False )
    is also<
      get-top-child
      top_child
      top-child
    >
  {
    propReturnObject(
      gsk_blend_node_get_top_child($!gsk-bn),
      $raw,
      |GSK::RenderNode.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_blend_node_get_type, $n, $t );
  }

}
