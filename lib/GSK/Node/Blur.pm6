use v6.c;

use Method::Also;

use GSK::Raw::Types:ver<4>;
use GSK::Raw::RenderNodes:ver<4>;

use GSK::RenderNode:ver<4>;

use GLib::Roles::Implementor;

our subset GskBlurNodeAncestry is export of Mu
  where GskBlurNode | GskRenderNode;

class GSK::Node::Blur:ver<4> is GSK::RenderNode:ver<4> {
  also does GLib::Roles::Implementor;

  has GskBlurNode $!gsk-bn is implementor;

  submethod BUILD ( :$gsk-transform-node ) {
    self.setGskBlurNode($gsk-transform-node) if $gsk-transform-node
  }

  method setGskBlurNode (GskBlurNodeAncestry $_) {
    my $to-parent;

    $!gsk-bn = do {
      when GskBlurNode {
        $to-parent = cast(GskRenderNode, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GskBlurNode, $_);
      }
    }
    self.setGskRenderNode($to-parent);
  }

  method GSK::Raw::Definitions::GskBlurNode
    is also<GskBlurNode>
  { $!gsk-bn }

  multi method new (GskBlurNodeAncestry $gsk-transform-node, :$ref = True) {
    return unless $gsk-transform-node;

    my $o = self.bless( :$gsk-transform-node );
    $o.ref if $ref;
    $o;
  }
  multi method new (GskRenderNode() $child, Num() $radius) {
    my gfloat $r = $radius;

    my $gsk-blur-node = gsk_blur_node_new($child, $radius);

    $gsk-blur-node ?? self.bless( :$gsk-blur-node ) !! Nil;
  }

  method get_child ( :$raw = False )
    is also<
      get-child
      child
    >
  {
    propReturnObject(
      gsk_blur_node_get_child($!gsk-bn),
      $raw,
      |GSK::RenderNode.getTypePair
    );
  }

  method get_radius
    is also<
      get-radius
      radius
    >
  {
    gsk_blur_node_get_radius($!gsk-bn);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gsk_blur_node_get_type, $n, $t );
  }

}
